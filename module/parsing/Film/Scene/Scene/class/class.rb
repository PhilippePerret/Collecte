class Film
class Scene
class << self

  # Initialise le comptage des scènes
  # La méthode est appelée à chaque début de parsing
  def init
    @last_id = 0
    @last_numero = 0
  end

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
