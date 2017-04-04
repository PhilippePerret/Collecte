# encoding: UTF-8
class Film
class Scene

  # Le bloc de code
  attr_reader :bunch_code

  # Méthode pour parser un bloc de définition
  # de scène
  def parse bloc
    @bunch_code = bloc
    # Il faut un identifiant
    @id = self.class.new_id
    # Il faut le numéro
    @numero = self.class.new_numero
    # On pase la première ligne
    parse_first_line
    @resume       = parse_line(second_line)
    @paragraphes  = Array.new
    other_lines.each do |line|
      @paragraphes << parse_line(line)
    end
  end

  REG_FIRST_LINE_SCENE =
    /^((?:[0-9]:)?(?:[0-9]?[0-9]:[0-9]?[0-9])) (EXT\.|INT\.|NOIR)(?: ?\/ ?(EXT\.|INT\.|NOIR))? (JOUR|NUIT|MATIN|SOIR|NOIR)(?: ?\/ ?(JOUR|NUIT|MATIN|SOIR|NOIR))? (.*?)(?: ?\/ ?(.*?))?$/

  def parse_first_line
    tout,
    @horloge,
    @lieu,
    @lieu_alt,
    @effet,
    @effet_alt,
    @decor,
    @decor_alt =
      first_line.match(REG_FIRST_LINE_SCENE).to_a

    @horloge = Film::Horloge.new(film, @horloge)

    # TODO Il faut ajouter le décor à la liste des décors
    # du film

  end

  # Méthode qui permet de parser une ligne.
  # La méthode retourne un objet FilmObjet
  def parse_line line
    case line
    when /^(b|n|p|s)([0-9]+)/i
      #
      # L I G N E   D E   R E L A T I F S
      #
      # C'est la dernière ligne possible de la scène.

      # TODO

    when /^\([0-9]+\) /
      #
      # L I G N E   D E   N O T E
      #
      tout, index_note, description_note = line.match(/^\(([0-9]+)\) (.*?)$/).to_a
      lanote = film.notes[index_note.to_i]
      lanote.parse(tout)
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
