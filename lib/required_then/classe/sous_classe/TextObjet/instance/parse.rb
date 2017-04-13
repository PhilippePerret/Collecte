# encoding: UTF-8
class Film
class TextObjet

  REG_HORLOGE = /((?:[0-9]:)?(?:[0-9]{1,2}:)?(?:[0-9]{1,2}))/

  REG_PERSONNAGE = /\[PERSO\#(.*?)\]/

  # Méthode principale qui parse une ligne de collecte
  # pour en faire un texte-objet.
  def parse line
    line != nil || raise("Un texte-objet ne peut être parsé avec une line nil…")
    @raw      = line
    @only_str = raw.strip

    if res = raw.match(/^#{REG_HORLOGE} /)
      hor = res.to_a[1]
      @horloge = Film::Horloge.new(self.film, hor)
      # On supprime l'horloge du texte seul.
      @only_str.sub!(/^#{REG_HORLOGE} /,'')
    end

    # Relève des personnages du film
    @personnages_ids = Array.new
    raw.scan(REG_PERSONNAGE).to_a.each do |found|
      pid = found.first
      @personnages_ids << pid
      # Dans @only_str, on remplace les balises par les
      # pseudos des personnages
      perso = film.personnages[pid]
      if perso
        @only_str.gsub(/\[PERSO\##{pid}\]/, perso.pseudo)
      else
        # Problème de personnage inconnu
        begin
          raise "Le personnage d'identifiant #{pid.inspect} n'est pas défini dans le fichier des personnages."
        rescue Exception => e
          log "PERSONNAGE INCONNU", error: e
        end
      end
    end

    # On va réduire la fin si elle définit des brins
    # ou des notes
    @notes_ids = Array.new
    @brins_ids = Array.new
    # log "#{RC}@only_str avant la boucle: #{@only_str.inspect}"
    fini = false
    while !fini
      @only_str = @only_str.strip
      case @only_str
      when /\([0-9]+\)$/
        # R E L A T I O N   À   U N E   N O T E
        @only_str.sub!(/\(([0-9]+)\)$/){
          @notes_ids << $1.to_i
          ''
        }
      when / b([0-9]+)$/i
        # A P P A R T E N A N C E   À   U N   B R I N
        @only_str.sub!(/ b([0-9]+)$/i){
          @brins_ids << $1.to_i
          ''
        }
      else
        # Sinon, c'est fini
        fini = true
      end

    end
    # log "@only_str après la boucle: #{@only_str.inspect}"

    # On remet les listes à l'endroit, car on peut mettre
    # les éléments par ordre d'importance. Or, ils ont été
    # entrés dans l'ordre inverse.
    @brins_ids = @brins_ids.reverse
    @notes_ids = @notes_ids.reverse!


  end

end #/TextObjet
end #/Film
