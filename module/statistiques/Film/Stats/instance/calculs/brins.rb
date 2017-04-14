# encoding: UTF-8
class Film
class Statistiques

  def nombre_brins
    @nombre_brins ||= brins.count
  end

  # Retourne un Array de brins en fonction de
  # leur présence, du plus présent au moins présent.
  def brins_par_temps_presence
    @brins_par_temps_presence ||= begin
      calcule_temps_par_brin
      brins.sort_by { |p| - p.presence }
    end
  end

  def calcule_temps_par_brin
    brins.each do |brin|
      brin.presence(scenes) # force simplement son calcul
    end
  end

end #/Statistiques
end #/Film

class Film
class Brin

  # Retourne le temps de présence dans les scènes
  # spécifiées
  # Noter qu'il s'agit d'une variable définie une seule fois,
  # en considérant qu'elle est utile pour une collecte en
  # particulier.
  def presence in_scenes = nil
    @presence ||= calcule_temps_presence_in_scenes(in_scenes)
  end

  def calcule_temps_presence_in_scenes in_scenes
    in_scenes ||= film.scenes
    p = 0
    in_scenes.each do |scene|
      scene.brins_ids || next
      scene.brins_ids.include?(id) || next
      p += scene.duree
    end
    return p
  end

end #/Brin
end #/Film
