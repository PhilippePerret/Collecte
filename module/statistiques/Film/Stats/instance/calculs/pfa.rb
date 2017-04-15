# encoding: UTF-8
class Film
class Statistiques

  # Retourne "Nombre points structurels définis / Nombre total"
  def nombre_points_structurels
    @nombre_points_structurels ||= begin
      "#{points_structurels.count} sur #{Film::Structure::Point::ABS_POINTS_DATA.count}"
    end
  end

  # Retourne, pour l'affichage, les nœuds définis et ceux qui ne le
  # sont pas
  def points_in_et_out
    pts_in  = Array.new
    pts_out = Array.new
    Film::Structure::Point::ABS_POINTS_DATA.each do |ptid, ptdata|
      if points_structurels.key? ptid
        pts_in << ptdata[:hname]
      else
        pts_out << ptdata[:hname]
      end
    end
    div("Points définis : #{pts_in.join(', ').downcase}.") +
    div("Points non définis : #{pts_out.join(', ')}.downcase")
  end

  def points_structurels
    @points_structurels ||= begin
      hpts = Hash.new
      scenes.each do |scene|
        scene.stt_points_ids || next
        log "La scène #{scene.numero} contient les points structurels : #{scene.stt_points_ids.inspect}"
        scene.points_structurels.each do |pt_stt|
          hpts.merge! pt_stt.id => [pt_stt, scene]
        end
      end
      hpts
    end
  end

  # Données PFA du film.
  # Cette méthode ajoute à la donnée film.structure les valeurs
  # absolues correspondant au paradigme de Field augmenté
  def helper_pfa

    # Film::Structure::Point::ABS_POINTS_DATA.each do |spt_id, spt_data|
    #   point_structure =
    # end

    c = Array.new

    points_structurels.each do |pt_id, pt_data|
      pt_stt, scene = pt_data
      ligne_pt_stt = [:data, pt_stt.name, pt_stt.zone_pfa_h]
      if pt_stt.in_zone?
        ligne_pt_stt << "#{pt_stt.zone_relative_h} => OK"
      else
        ligne_pt_stt << span("HORS-ZONE (#{pt_stt.zone_relative_h})<br>#{pt_stt.offset_litt}",{class:'red center'})
      end
      c << ligne_pt_stt
    end

    if c.count > 0
      c = [
        [:titre, 'MODÈLE DE FIELD (PFA)'],
        [:titre, 'Positions par rapport au modèle de Field'],
        [:section_in],
        [:libelles, 'Point structurel', 'position absolue', 'position dans le film']
      ] + c + [
        [:section_out]
      ]
    end

    return c
  end

end #/Statistiques
end #/Film
