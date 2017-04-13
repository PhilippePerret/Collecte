# encoding: UTF-8
class Film

  def stats
    @stats ||= Statistiques.new(self)
  end

  class Statistiques

    def initialize film
      @film = film
    end

  end #/Statistiques
end #/Film
