# encoding: UTF-8
class Film
class Statistiques


  def nombre_scenes
    @nombre_scenes ||= begin
      self.scenes.count
    end
  end
  def scenes_classees
    @scenes_classees ||= scenes.sort_by{|scene| - scene.duree}
  end

  # Retourne la liste des 10 plus longues scènes
  # Array de Film::Scene
  def ten_longest_scenes
    @ten_longest_scenes ||= scenes_classees[1..10]
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
    @longest_scene ||= scenes_classees.first
  end
  def value_shortest_scene
    "Scène #{shortest_scene.numero} #{shortest_scene.duree.s2h} (#{shortest_scene.resume.to_html})"
  end
  def shortest_scene
    @shortest_scene ||= scenes_classees.last
  end

end #/Statistiques
end #/Film
