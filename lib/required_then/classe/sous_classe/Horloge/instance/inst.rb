# encoding: UTF-8
class Film
class Horloge

  def initialize film, horl
    @film     = film
    case horl
    when String
      @time     = horl.h2s
      @horloge  = @time.s2h # pour l'avoir toujours complète
    when Hash
      horl.each{|k,v|instance_variable_set("@#{k}",v)}
    end
  end

end #/Horloge
end #/Film
