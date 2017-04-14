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

  # Seulement les personnages qui sont contenus dans la
  # zone de temps défini ou le filtre.
  # Noter que contrairement à film.personnages, il s'agit
  # d'un Array
  # Pour obtenir cette valeur : collecte.extractor.personnages
  def personnages
    @personnages ||= begin
      arr = Array.new
      scenes.each do |scene|
        scene.personnages_ids || next
        arr += scene.personnages_ids
      end
      arr = arr.uniq
      log "Liste des IDs de personnages retenus : #{arr.inspect}"
      arr.collect do |perso_id|
        film.personnages[perso_id]
      end
    end
  end

  def brins
    @brins ||= begin
      arr = Array.new
      scenes.each do |scene|
        scene.brins_ids || next
        arr += scene.brins_ids
      end
      arr = arr.uniq
      log "Liste des IDs de brins retenus : #{arr.inspect}"
      arr.collect do |brin_id|
        film.brins[brin_id]
      end
    end
  end

  def scene_is_in scene
    scene.time >= from_time || raise('> à from_time')
    scene.time <= to_time   || raise('< à to_time')
    options[:filter].nil? || begin
      [:brins, :personnages, :notes].each do |prop|
        options[:filter].key?(prop) || next
        scene.send("#{prop}_ids".to_sym).passe_filtre?(options[:filter][prop]) || raise('hors conditions')
      end
    end
    return true
  rescue Exception => e
    log "Scène #{scene.numero} (#{scene.horloge.horloge}) filtrée : #{e.message}"
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
