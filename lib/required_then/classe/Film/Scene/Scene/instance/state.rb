# encoding: UTF-8
class Film
class Scene

  # Retourne true si la scène est la première d'une
  # partie, développement ou dénouement.
  def premiere_scene_acte?
    if @is_premiere_scene_acte === nil
      @is_premiere_scene_acte = contient_un_point_charniere
    end
    @is_premiere_scene_acte
  end
  def contient_un_point_charniere
    stt_points_ids != nil || (return false)
    stt_points_ids.each do |ptstt_id|
      return true if [:dev_part1, :dev_part2, :denouement].include?(ptstt_id)
    end
    return false
  end

end #/Scene
end #/Film
