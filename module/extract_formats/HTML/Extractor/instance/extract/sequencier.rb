# encoding: UTF-8
#
# Méthodes d'extraction des données propres au format
# HTML
#
Collecte.require_module 'html_methods'
class Collecte
class Extractor

  # ---------------------------------------------------------------------
  #   Méthodes utilisées quand on doit extraire un
  #   séquencier
  # ---------------------------------------------------------------------
  def extract_sequencier

    # On calcule le template de l'intitulé en fonction
    # des choix d'options
    Film::Scene.build_template_intitule(options)

    final_file.title = final_file.titre_final # balise title
    write div(final_file.titre_final, id: 'titre')

    if scenes.count == 0
      # => Aucune scène n'a été inscrite
      begin
        entrela = from_time > 0 ? from_time.s2h : 'le début du film'
        etla  = to_time < Float::INFINITY ? to_time.s2h : 'la fin du film'
        raise "Aucune scène n'est comprise entre #{entrela} et #{etla}."
      rescue Exception => e
        log '', error: e
      end
    else
      # ÉCRITURE DE LA TIMELINE (if any)
      options[:no_timeline] || write(film.timeline.as_div)

      # ÉCRITURE DE TOUTES LES SCÈNES
      # -----------------------------
      write '<section id="sequencier" class="scenes">'
      if options[:suggest_structure]
        scenes.each do |scene|
          if scene.time > next_structure_time
            # On passe le prochain temps structurel,
            # on doit le marquer.
            franchir_next_structure_time(scene)
          end
          write scene.as_sequence
        end
      else
        scenes.each do |scene|
          write scene.as_sequence
        end
      end
      write '</section>'
    end

    final_file.flush

    # On extrait toutes les fiches des éléments pour
    # les voir.
    extract_fiches_personnages
    extract_fiches_brins
    extract_fiches_notes

  end

  # Retourne le prochain temps structure attendu lorsqu'on
  # demande des suggestions concernant la structure.
  def next_structure_time
    @next_structure_time ||= begin
      @points_structurels = points_structurels
      @next_point_structurel = @points_structurels.shift
      # Le premier point est calculé par cette méthode, les
      # points suivants sont mis en fonction du passage au
      # point suivant
      @next_point_structurel[:time]
    end
  end
  # Appelé lorsque le prochain temps structurel est dépassé
  def franchir_next_structure_time scene
    write div(@next_point_structurel[:name], {class: 'stt'})
    @next_point_structurel = @points_structurels.shift
    puts "@next_point_structurel: #{@next_point_structurel.inspect}"
    @next_structure_time  = @next_point_structurel[:time]
  end
  # Liste des points structurels
  def points_structurels
    [
      {time: film.zone_pivot_1.time, name: 'Début de la Zone Pivot 1'},
      {time: film.quart, name: 'Début du Développement'},
      {time: film.zone_cle_de_voute.time, name: 'Début de la Zone Clé de voûte'},
      {time: film.zone_cle_de_voute.end_time, name: 'Fin de la Zone Clé de voûte'},
      {time: film.zone_pivot_2.time, name: 'Début de la Zone Pivot 2'},
      {time: film.trois_quarts, name: 'Début du Dénouement'},
      {time: film.fin.time + 100, name: 'Fin du film'}
    ]
  end

end #/Extractor
end #/Collecte
