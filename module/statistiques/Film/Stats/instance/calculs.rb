# encoding: UTF-8
class Film
class Statistiques


  def nombre_scenes
    @nombre_scenes ||= begin
      self.scenes.count
    end
  end

  def temps_moyen_scene_str
    @temps_moyen_scene_str ||= temps_moyen_scene.s2h
  end
  def temps_moyen_scene
    @temps_moyen_scene ||= (film.duree.to_f / nombre_scenes).to_i
  end

  def value_longest_scene
    "Scène #{longest_scene.numero} #{longest_scene.duree.s2h} #{longest_scene.resume.to_html}"
  end
  def longest_scene
    @longest_scene ||= begin
      longest = scenes.first
      scenes.each do |scene|
        scene.duree <= longest.duree || longest = scene
      end
      longest
    end
  end

  def value_shortest_scene
    "Scène #{shortest_scene.numero} #{shortest_scene.duree.s2h} (#{shortest_scene.resume.to_html})"
  end
  def shortest_scene
    @shortest_scene ||= begin
      shortest = scenes.first
      scenes.each do |scene|
        scene.duree >= shortest.duree || shortest = scene
      end
      shortest
    end
  end

  def nombre_personnages
    @nombre_personnages ||= personnages.count
  end
end #/Statistiques
end #/Film
