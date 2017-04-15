# encoding: UTF-8
class Film
class Decor

  # Méthodes communes aux objets relatifs, tels que les
  # brins, les scènes, les personnages, les notes, etc.
  include RelativeObjectMethods

  def initialize film, data = nil
    @film   = film
    data.nil? || data.each{|k,v|instance_variable_set("@#{k}",v)}
  end

end #/Decor
end #/Film
