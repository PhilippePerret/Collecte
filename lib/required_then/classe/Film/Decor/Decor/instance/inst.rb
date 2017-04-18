# encoding: UTF-8
class Film
class Decor

  # Méthodes communes aux objets relatifs, tels que les
  # brins, les scènes, les personnages, les notes, etc.
  include RelativeObjectMethods

  def initialize film, data = nil
    @film   = film
    data.nil? || data.each{|k,v|instance_variable_set("@#{k}",v)}
    # Pour transformer, à la création, le "INT." en "I", etc.
    @lieu && @lieu.length > 1 && @lieu = @lieu[0]
    @id ||= self.class.new_id
  end

end #/Decor
end #/Film
