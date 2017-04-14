# encoding: UTF-8
class Film
class Scenes

  # Les méthodes de collecte communes à tous les fichiers,
  # personnages, brins et scènes.
  include CollecteFileMethods

  # Méthode d'ajout d'un personnage dans la liste des
  # personnages du film.
  def add bloc
    item = Film::Scene.new(self.film)
    item.parse(bloc.code)
    # Si c'est la dernière scène, on ne l'ajoute pas
    # à la liste des scènes mais on s'en sert pour
    # indiquer la durée du film
    # @nombre_scenes_added ||= 0
    if item.lieu == 'FIN'
      film.fin = item.horloge
      log "FIN DU FILM TROUVÉE à #{film.fin.horloge}"
    else
      item.line = bloc.line
      # @nombre_scenes_added += 1
      self << item
    end
    # log "Nombre de scènes : #{@nombre_scenes_added}"
  rescue BadBlocData => e
    log "Mauvaises données pour un bloc de scène", error: e
  end

end #/Scenes
end #/Film
