# encoding: UTF-8
class Film
class Scenes

  # Méthode qui va établir :
  #   - personnages_ids dans la scène
  #   - scenes_ids dans le personnage.
  #
  # Les personnages sont recherchés dans les résumés de
  # scène et les paragraphes.
  def parse_presence_personnages
    film.scenes.each do |sid, s|
      p_ids = Array.new
      p_ids += Film::Personnage::personnages_ids_in(s.resume)
      s.paragraphes.each do |parag|
        p_ids += Film::Personnage::personnages_ids_in(parag)
      end
      # On ajoute ces personnages à la scène
      s.personnages_ids = p_ids.uniq
      log "    = Personnages de scène #{sid} : #{s.personnages_ids.join(', ')}"
      # On ajoute cette scène aux personnages
      p_ids.each{|pid| film.personnages[pid].add_scene sid}
    end
  end

end #/Scenes
end #/Film
