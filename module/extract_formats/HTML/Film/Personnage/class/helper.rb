# encoding: UTF-8
class Film
class Personnage
class << self

  # Pour les tests
  # Film::Personnage.init
  def init
    @film = nil
  end

  def film
    @film ||= Collecte.current.film
  end

  # Traite les balises [PERSO#<id>] dans +code+
  def traite_balises_in code
    code.gsub(/\[PERSO\#(.*?)\]/){
      pid = $1
      perso = film.personnages[pid]
      perso != nil || begin
        log "### ERREUR Personnage inconnu : `#{pid}'"
        # On tente de reparser le fichier personnage ?
        log '# PERSONNAGES COURANTS'
        film.personnages.each do |pid, perso|
          log "#   Perso ##{pid} (#{perso.prenom} #{perso.nom})"
        end
        log '# FIN PERSONNAGES'
        log "# Dossier de collecte : #{Collecte.current.path.inspect}"
        # On tente de re-collecter les personnages
        # Collecte.require_module 'parsing'
        log 'Tentative de rechargement des données du film…'
        film.load
        film.personnages[pid] || begin
          # Cette fois, on est sûr que le personnage n'existe pas…
          raise("Impossible d'obtenir le personnage ##{pid}. Il faut le définir impérativement (voir dans le log la liste des personnages courants).")
        end
      end
      perso.as_link
    }
  end

end #/<< self
end #/Personnage
end #/Film
