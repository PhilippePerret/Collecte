# encoding: UTF-8
class Film
class Scene

  def hduree
    @hduree ||= duree ? duree.s2h : nil
  end

  # Renvoie les temps de début et de fin de la scène,
  # sous forme d'horloge "H:MM:SS-H:MM:SS"
  def debut_fin
    @debut_fin ||= begin
      df = String.new
      "#{horloge.real_time.s2h}-#{horloge.real_end_time.s2h}"
    end
  end
end #/Scene
end #/Film
