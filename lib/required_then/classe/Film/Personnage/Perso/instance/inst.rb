# encoding: UTF-8
class Film
class Personnage

  # Méthodes communes aux objets relatifs, tels que les
  # brins, les scènes, les personnages, les notes, etc.
  include RelativeObjectMethods

  def initialize film
    @film = film
  end

end #/Personnage
end #/Film
