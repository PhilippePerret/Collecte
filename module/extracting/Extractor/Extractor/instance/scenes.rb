# encoding: UTF-8
class Collecte
class Extractor

  # {Array de Film::Scene} Liste des scènes qu'il faut
  # extraire, après filtrage par le temps et les autres
  # options
  def scenes
    @scenes ||= begin
      film.scenes.collect do |scene_id, scene|
        scene_is_in(scene) ? scene : nil
      end.compact
    end
  end
  def scene_is_in scene
    scene.time >= from_time || raise
    scene.time <= to_time   || raise
    options[:filter].nil? || begin
      [:brins, :personnages, :notes].each do |prop|
        options[:filter].key?(prop) || next
        scene.send("#{prop}_ids".to_sym).passe_filtre?(options[:filter][prop]) || raise
      end
    end
    return true
  rescue
    return false
  end

  def from_time
    @from_time ||= (options[:from_time] || 0)
  end
  def to_time
    @to_time ||= (options[:to_time] || Float::INFINITY)
  end

end #/Extractor
end #/Collect
