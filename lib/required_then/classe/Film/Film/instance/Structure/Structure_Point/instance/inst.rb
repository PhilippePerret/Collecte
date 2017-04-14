# encoding: UTF-8
class Film
class Structure
class Point

  def initialize film, id, data = nil
    @id = id
    data.nil? || begin
      @data = data
    end
  end

end #/Point
end #/Structure
end #/Film
