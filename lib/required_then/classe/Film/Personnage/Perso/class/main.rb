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

end #/<< self
end #/Personnage
end #/Film
