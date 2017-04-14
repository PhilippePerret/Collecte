# encoding: UTF-8
class Film
class Statistiques

  def nombre_personnages
    @nombre_personnages ||= personnages.count
  end

  # Retourne un Array de personnages en fonction de
  # leur présence, du plus présent au moins présent.
  def personnages_par_temps_presence
    @personnages_par_temps_presence ||= begin
      calcule_temps_par_personnage
      personnages.sort_by { |p| - p.presence }
    end
  end

  def calcule_temps_par_personnage
    personnages.each do |perso|
      perso.presence(scenes) # force simplement son calcul
    end
  end

end #/Statistiques
end #/Film

class Film
class Personnage

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
      scene.personnages_ids || next
      scene.personnages_ids.include?(id) || next
      p += scene.duree
    end
    return p
  end

end #/Personnage
end #/Film
