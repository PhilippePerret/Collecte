# encoding: UTF-8
class Film
class Decor

  def scenes
    @scenes ||= begin
      h = Hash.new ; (scenes_ids||[]).each do |sid|
        h.merge!(sid => film.scenes[sid])
      end ; h
    end
  end

  def add_scene sc
    @scenes_ids ||= Array.new
    @scenes = nil # Pour forcer l'actualisation
    @scenes_ids << sc.id
  end
end #/Decor
end #/Film
