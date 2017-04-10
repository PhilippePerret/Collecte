# encoding: UTF-8
class Film
class Scene

  # Le bloc de code qui permet de définir la scène
  attr_reader :bunch_code

  OBJECTS_PROPERTIES = [
    :brins_ids, :notes_ids, :personnages_ids, :scenes_ids
  ]

  # Méthode pour parser un bloc de définition
  # de scène
  def parse bloc
    @bunch_code = bloc.strip
    # Il faut un identifiant
    @id = self.class.new_id
    # Il faut le numéro
    @numero     = self.class.new_numero

    # Initialisation des relatifs
    @notes_ids        = Array.new
    @brins_ids        = Array.new
    @scenes_ids       = Array.new
    @personnages_ids  = Array.new

    # On passe la première ligne
    parse_first_line
    @resume       = parse_line(second_line)
    # Si le résumé possède des objets relatifs, il faut
    # les mettre dans la scène elle-même.
    OBJECTS_PROPERTIES.each do |prop|
      instance_variable_set("@#{prop}", @resume.send(prop))
    end
    @paragraphes  = Array.new
    other_lines.each do |line|
      fto = parse_line(line)
      fto.nil? || @paragraphes << fto
    end
    # On récupère tous les relatifs des paragraphes
    @paragraphes.each do |paragraphe|
      paragraphe.brins_ids.nil? || @brins_ids += paragraphe.brins_ids
      paragraphe.notes_ids.nil? || @notes_ids += paragraphe.notes_ids
      paragraphe.scenes_ids.nil? || @scenes_ids += paragraphe.scenes_ids
      paragraphe.personnages_ids.nil? || @personnages_ids += paragraphe.personnages_ids
    end

    # On mets les relatifs à nil quand il sont vides
    @brins_ids        = @brins_ids.nil_if_empty
    @notes_ids        = @notes_ids.nil_if_empty
    @scenes_ids       = @scenes_ids.nil_if_empty
    @personnages_ids  = @personnages_ids.nil_if_empty

  end

  REG_FIRST_LINE_SCENE =
    /^((?:[0-9]:)?(?:[0-9]?[0-9]:[0-9]?[0-9])) (EXT\.|INT\.|NOIR)(?: ?\/ ?(EXT\.|INT\.|NOIR))? (JOUR|NUIT|MATIN|SOIR|NOIR)(?: ?\/ ?(JOUR|NUIT|MATIN|SOIR|NOIR))? (.*?)(?: ?\/ ?(.*?))?$/

  REG_FIRST_LINE_SCENE_SIMPLE =
    /^((?:[0-9]:)?(?:[0-9]?[0-9]:[0-9]?[0-9])) (NOIR)( GENERIQUE| GÉNÉRIQUE)?$/

  def parse_first_line
    if first_line.match(REG_FIRST_LINE_SCENE)
      @horloge,
      @lieu,
      @lieu_alt,
      @effet,
      @effet_alt,
      @decor,
      @decor_alt =
        first_line.match(REG_FIRST_LINE_SCENE).to_a[1..-1]
    elsif first_line.match(REG_FIRST_LINE_SCENE_SIMPLE)
      @horloge,
      @lieu =
        first_line.match(REG_FIRST_LINE_SCENE_SIMPLE).to_a[1..-1]
    else
      raise "L’intitulé de la scène #{numero} est mal formaté (#{first_line.inspect})"
    end

    # Erreur de mauvais formatage.
    if @horloge.nil? || @lieu.nil? || (@lieu != 'NOIR' && @effet.nil?)
      raise BadBlocData, "La première ligne de la scène #{bunch_code.inspect} est mal formatée. Impossible de décomposer l'intitulé."
    end

    @horloge = Film::Horloge.new(film, @horloge)

    # TODO Il faut ajouter le décor à la liste des décors
    # du film

  end

  RELATIVE_MARK_TO_RELATIVE = {
    'b' => :brins,
    'p' => :personnages,
    'n' => :notes,
    's' => :scenes
  }
  # Méthode qui permet de parser une ligne.
  # La méthode retourne un objet FilmObjet
  def parse_line line
    case line
    when /^(b|n|p|s)([0-9]+)/i
      #
      # L I G N E   D E   R E L A T I F S
      #
      # C'est la dernière ligne possible de la scène.

      line.split(' ').each do |relmark|
        rel_mark, rel_id = relmark.match(/^(b|n|p|s)([0-9]+)$/i).to_a[1..-1]
        rel_id = rel_id.to_i
        prop = RELATIVE_MARK_TO_RELATIVE[rel_mark]
        liste = self.send("#{prop}_ids".to_sym) || Array.new
        liste << rel_id
        instance_variable_set("@#{prop}_ids", liste)
      end

      return nil

    when /^\([0-9]+\) /
      #
      # L I G N E   D E   N O T E
      #
      tout, index_note = line.match(/^\(([0-9]+)\) (.*?)$/).to_a[0..1]
      lanote = film.notes[index_note.to_i]
      lanote.parse(tout)
      # On peut définir une note dans une scène sans l'utiliser,
      # même si c'est un peu absurde. Mais cette note sera
      # surtout ajoutée par une autre marque.
      # @notes_ids << lanote.id
      return nil
    else
      #
      # A U T R E   L I G N E
      #
      fo = Film::TextObjet.new(film)
      fo.parse(line)
      fo.scene_id = self.id
      return fo
    end
  end

  def first_line
    @first_line ||= lines.first
  end
  def second_line
    @second_line ||= lines[1]
  end
  def other_lines
    @other_lines ||= lines[2..-1]
  end

  # Toutes les lignes du bloc de scène
  def lines
    @lines ||= bunch_code.split(RC).collect { |l| l.strip }
  end

end #/Scene
end #/Film
