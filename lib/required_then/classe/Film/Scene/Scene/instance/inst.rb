# encoding: UTF-8
class Film
class Scene

  # Méthodes communes aux objets relatifs, tels que les
  # brins, les scènes, les personnages, les notes, etc.
  include RelativeObjectMethods

  def initialize film
    @film = film
    # Ne surtout pas ajouter la scène aux scènes (film.scenes)
    # ici car la dernière ligne, qui marque simplement la
    # fin du film, serait considérée comme une scène du film.
  end

end #/Scene
end #/Film
