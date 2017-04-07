# encoding: UTF-8
class Film
class Horloge

  def initialize film, horl
    @film     = film
    @time     = horl.h2s
    @horloge  = @time.s2h # pour l'avoir toujours complète
  end

end #/Horloge
end #/Film
