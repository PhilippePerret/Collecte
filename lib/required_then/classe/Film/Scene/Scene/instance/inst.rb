# encoding: UTF-8
class Film
class Scene

  # Méthodes communes aux objets relatifs, tels que les
  # brins, les scènes, les personnages, les notes, etc.
  include RelativeObjectMethods

  def initialize film
    @film = film
  end

end #/Scene
end #/Film
