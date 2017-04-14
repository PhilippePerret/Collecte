# encoding: UTF-8
class Film
class Scenes

  def calcule_durees
    film.scenes.each do |ks, s|
      s.set_duree
      # log "Durée de scène ##{s.numero} fixée à #{s.duree}"
    end
  end
end #/Scenes
end #/Film
