# encoding: UTF-8
class Film
class Personnages

  # Les méthodes de collecte communes à tous les fichiers,
  # personnages, brins et scènes.
  include CollecteFileMethods

  # Méthode d'ajout d'un personnage dans la liste des
  # personnages du film.
  def add bloc
    @hash ||= Hash.new
    item = Film::Personnage.new(self.film)
    item.parse(bloc)
    @hash.merge!( item.id => item )
  rescue BadBlocData => e
    log "Mauvaises données pour un bloc de personnage", error: e
  end

end #/Personnages
end #/Film
