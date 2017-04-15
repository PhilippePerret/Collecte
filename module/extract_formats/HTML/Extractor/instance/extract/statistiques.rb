# encoding: UTF-8
class Collecte
class Extractor

  # = main =
  #
  # Extraction de la collecte sous forme d'un synopsis
  def extract_statistiques
    # log "-> Collecte::Extractor#extract_statistiques"
    Collecte.require_module 'statistiques'
    stats = film.stats

    # Le titre du document
    write div(final_file.titre_final, id: 'titre')
    write '<section class="statistiques">'

    # Templates qui vont servir à construire le code
    # des statistiques
    templates = {
      :titre        => "<div class='titre'>%s</div>",
      :libelles     => libvalval('%s', '%s', '%s', {class: 'libvalval libelles'}),
      :data         => libvalval('%s', '%s', '%s'),
      :section_in   => '<section class="groupe">',
      :section_out  => '</section>',
      :empty        => ''
    }


    shortscene = "<div>Scène #{stats.shortest_scene.numero}</div>#{stats.shortest_scene.resume.to_html}"
    longscene = "<div>Scène #{stats.longest_scene.numero}</div>#{stats.longest_scene.resume.to_html}"

    data_stats = [
      [:titre, 'DONNÉES GÉNÉRALES'],
      [:titre, 'Le film en chiffres'],
      [:section_in],
      [:libelles, 'nombre de…', 'nombre'],
      [:data, '… scènes', stats.nombre_scenes.to_s],
      [:data, '… personnages', stats.nombre_personnages],
      [:data, '… brins', stats.nombre_brins],
      [:data, '… points structurels définis', stats.nombre_points_structurels, stats.points_in_et_out],
      [:section_out],
      [:titre, 'SCÈNES'],
      [:section_in],
      [:data, 'Temps moyen par scène', stats.temps_moyen_scene_str],
      [:data, 'Plus courte scène', stats.shortest_scene.hduree, shortscene],
      [:data, 'Plus longue scène', stats.longest_scene.hduree, longscene],
      [:section_out],
      [:empty],
      [:titre, 'PERSONNAGES'],
      [:titre, 'Classement des personnages par temps de présence'],
      [:section_in],
      [:libelles, 'ID personnage', 'Patronyme', 'Présence dans le film']
    ] + stats.personnages_par_temps_presence.collect do |perso|
      # Données statistiques pour les personnages
      [:data, perso.id, perso.pseudo, perso.presence.s2h]
    end + [
      [:section_out],
      [:empty],
      [:titre, 'BRINS'],
      [:titre, 'Classement des brins par importance temporelle'],
      [:section_in],
      [:libelles, 'ID Brin', 'Libellé', 'Présence dans le film']
    ] + stats.brins_par_temps_presence.collect do |brin|
      # Données statistiques pour les brins
      [:data, brin.id, brin.libelle.to_html, brin.presence.s2h]
    end + [
      [:section_out],
      [:empty]
    ] + stats.helper_pfa

    log "STATISTIQUES : constitution du code"
    data_stats.each do |type, label, value1, value2|
      write templates[type] % [label.to_s, value1.to_s, value2.to_s]
    end.join(RC)
    log "STATISTIQUES : /fin de constitution du code"

    write '</section>' #/statistiques
    final_file.flush

    # Extraction des fiches
    extract_fiches_personnages
    extract_fiches_brins
  end

end #/Extractor
end #/Collecte
