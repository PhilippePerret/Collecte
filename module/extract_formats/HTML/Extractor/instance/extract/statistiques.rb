# encoding: UTF-8
class Collecte
class Extractor

  # = main =
  #
  # Extraction de la collecte sous forme d'un synopsis
  def extract_statistiques
    Collecte.require_module 'statistiques'
    stats = film.stats

    # Le titre du document
    write div(final_file.titre_final, id: 'titre')
    # On ne prend que les scènes filtrées
    write '<section class="statistiques">'
    write div('Pour le moment, aucune statistique n’est effectuée.')
    {
      'Nombre de scènes'      => stats.nombre_scenes,
      'Temps moyen par scène' => stats.temps_moyen_scene_str,
      'Plus longue scène'     => stats.value_shortest_scene,
      'Plus courte scène'     => stats.value_longest_scene,
      'Nombre de personnages' => stats.nombre_personnages
    }.collect do |kpaire, vpaire|
      write(libval(kpaire, vpaire))
    end

    write '</section>' #/statistiques
    final_file.flush

    # Extraction des fiches
    extract_fiches_personnages
    extract_fiches_brins
  end

end #/Extractor
end #/Collecte
