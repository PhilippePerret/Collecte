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

  # alias :extract_brin pour simplification des appels de
  # méthode d'extraction (cf dans set_by_type).
  def extract_sequencier

    # On calcule le template de l'intitulé en fonction
    # des choix d'options
    Film::Scene.build_template_intitule(options)

    # Le titre du document
    write div(final_file.titre_final, id: 'titre')

    log "Nombre de scènes passant le filtre : #{scenes.count}"

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
      # => S'il y a des scènes
      #
      # ÉCRITURE DE LA TIMELINE (if any)
      options[:no_timeline] || write(film.timeline.as_div)

      # ÉCRITURE DE TOUTES LES SCÈNES
      # -----------------------------
      write '<section id="sequencier" class="scenes">'
      if options[:suggest_structure]
        #
        # => Suggestion de la structure
        #
        @index_cur_pointstt = 0
        @next_pointstt = points_structurels[@index_cur_pointstt]
        # Le temps recherché
        next_pointstt_time = @next_pointstt[:time]

        scenes.each do |scene|
          # On boucle tant que le temps de la scène
          # est inférieur au prochain temps structurel
          # Par exemple, on attend de trouver le premier temps qui
          # correspond au temps de la zone du pivot 1.
          if scene.time > next_pointstt_time

            # Il faut écrire le point structurel courant
            write_point_structurel( @index_cur_pointstt )

            # On boucle jusqu'à trouver le prochain point temps
            # suivant, en écrivant dans le fichier tous les points
            # structurels se trouvant avant la scène courante.
            while scene.time > next_pointstt_time
              @index_cur_pointstt += 1
              @next_pointstt = points_structurels[@index_cur_pointstt]
              next_pointstt_time = @next_pointstt[:time]
              # Si le prochain point temps et encore inférieur au
              # temps de la scène, il faut le marquer
              if scene.time > next_pointstt_time
                write_point_structurel(@index_cur_pointstt)
              end
            end
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
  alias :extract_brin :extract_sequencier

  def write_point_structurel index_ptstt
    ptstt = points_structurels[index_ptstt]
    str = "#{(ptstt[:time]-film.start.time).s2h} #{ptstt[:name]} (tps collecte : #{ptstt[:time].s2h})"
    ptstt[:exact_time].nil? || str += " Position exacte : #{(ptstt[:exact_time]-film.start.time).s2h} (#{ptstt[:exact_time].s2h})"
    write div(str, {class: 'stt'})
    ptstt[:written] = true
  end

  # Indice du point structure courant
  def index_cur_pointstt
    @index_cur_pointstt ||= 0
  end

  # Liste des points structurels
  def points_structurels
    @points_structurels ||= begin
      [
        {time: film.zone_pivot_1.time, name: 'Début de la Zone du Pivot 1'},
        {time: film.quart, name: 'Début du Développement'},
        {time: film.zone_tiers.time, name: 'Début de la Zone du tiers'},
        {time: film.zone_tiers.end_time, name: 'Fin de la Zone du tiers'},
        {time: film.zone_cle_de_voute.time, exact_time: film.moitie, name: 'Début de la Zone Clé de voûte'},
        {time: film.zone_cle_de_voute.end_time, name: 'Fin de la Zone Clé de voûte'},
        {time: film.zone_deux_tiers.time, name: 'Début de la Zone des deux-tiers'},
        {time: film.zone_deux_tiers.end_time, name: 'Fin de la Zone des deux-tiers'},
        {time: film.zone_pivot_2.time, name: 'Début de la Zone du Pivot 2'},
        {time: film.trois_quarts, name: 'Début du Dénouement'},
        {time: film.zone_climax.time, name: 'Début de la Zone du Climax'},
        # Juste pour pouvoir toujours prendre le temps suivant :
        {time: film.fin.time + 100, name: 'Fin du film'}
      ]
    end
  end

end #/Extractor
end #/Collecte
