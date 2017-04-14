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
DONNÉES GÉNÉRALES
<section>
Nombre de scènes | #{stats.nombre_scenes} |
Temps moyen par scène | #{stats.temps_moyen_scene_str} |
Plus courte scène | #{stats.shortest_scene.duree.s2h} | <div>Scène #{stats.shortest_scene.numero}</div>#{stats.shortest_scene.resume.to_html}
Plus longue scène | #{stats.longest_scene.duree.s2h} | <div>Scène #{stats.longest_scene.numero}</div>#{stats.longest_scene.resume.to_html}
</section>

PERSONNAGES
<section>
Nombre de personnages | #{stats.nombre_personnages} |
</section>
Classement des personnages par temps de présence
<section>
    EOV

    stats.personnages_par_temps_presence.each do |perso|
      data_stats << "##{perso.id} | #{perso.pseudo} | #{perso.presence.s2h}#{RC}"
    end

    log "STATISTIQUES : données des brins"

    data_stats << <<-EOV
</section>

BRINS
<section>
Nombre de brins | #{stats.nombre_brins}
</section>
Classement des brins par importance temporelle
<section>
    EOV
    stats.brins_par_temps_presence.each do |brin|
      data_stats << "##{brin.id} | #{brin.libelle.to_html} | #{brin.presence.s2h}#{RC}"
    end

    data_stats << "</section>#{RC}"

    log "STATISTIQUES : constitution du code"
    write '<section class="statistiques">'
    data_stats.split(RC).collect do |line|
      lib, value1, value2 = line.split('|').collect{|i| i.strip}
      if value1
        write libval1val2(lib, value1, value2)
      elsif lib == '<section>'
        write '<section class="groupe">'
      elsif lib == '</section>'
        write lib
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
