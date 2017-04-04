class Film
class Scene
class << self

  def new_id
    @last_id ||= 0
    @last_id += 1
  end

  def new_numero
    @last_numero ||= 0
    @last_numero += 1
  end

end #/<< self
end #/Scene
end #/Film
