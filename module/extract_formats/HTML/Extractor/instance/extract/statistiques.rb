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
    # On ne prend que les scènes filtrées

    log "STATISTIQUES : données générales"
    data_stats = <<-EOV
Nombre de scènes | #{stats.nombre_scenes} |
Temps moyen par scène | #{stats.temps_moyen_scene_str} |
Plus longue scène | #{stats.value_shortest_scene} |
Plus courte scène | #{stats.value_longest_scene} |

PERSONNAGES
Nombre de personnages | #{stats.nombre_personnages} |
Classement des personnages par temps de présence
    EOV

    stats.personnages_par_temps_presence.each do |perso|
      data_stats << "##{perso.id} | #{perso.pseudo} | #{perso.presence.s2h}#{RC}"
    end

    log "STATISTIQUES : données des brins"

    data_stats << <<-EOV

BRINS
Nombre de brins | #{stats.nombre_brins}
Classement des brins par importance temporelle
    EOV
    stats.brins_par_temps_presence.each do |brin|
      data_stats << "##{brin.id} | #{brin.titre.to_htm[0..50]} | #{brin.presence.s2h}#{RC}"
    end

    log "STATISTIQUES : constitution du code"
    write '<section class="statistiques">'
    data_stats.split(RC).collect do |line|
      lib, value1, value2 = line.split('|').collect{|i| i.strip}
      if value1
        write libval1val2(lib, value1, value2)
      else
        # => un titre
        write(div(lib, {class: 'titre'}))
      end
    end
    log "STATISTIQUES : /fin de constitution du code"

    write '</section>' #/statistiques
    final_file.flush

    # Extraction des fiches
    extract_fiches_personnages
    extract_fiches_brins
  end

end #/Extractor
end #/Collecte
