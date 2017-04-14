# encoding: UTF-8
class Film
  def structure
    @structure ||= Structure.new(self)
  end

class Structure
  def initialize film
    @film = film
  end
end #/Structure
end #/Film
