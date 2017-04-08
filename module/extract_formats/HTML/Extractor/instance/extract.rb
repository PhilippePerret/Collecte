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

      # LISTE DES SCÈNES
      write '<section id="sequencier" class="scenes">'
      scenes.each do |scene|
        write scene.as_sequence
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

  def extract_fiches_personnages
    film.personnages || return
    film.personnages.each do |perso_id, perso|
      write perso.as_fiche
    end
    final_file.flush
  end
  def extract_fiches_brins
    film.brins || return
    film.brins.each do |bid, brin|
      write brin.as_fiche
    end
    final_file.flush
  end
  def extract_fiches_notes
    film.notes || return
    film.notes.each do |nid, note|
      write note.as_fiche
    end
    final_file.flush
  end

  # ---------------------------------------------------------------------
  #   Méthodes utilisées quand on doit extraire toutes
  #   les données
  # ---------------------------------------------------------------------

  def extract_meta_data
    write '<metadata class="liste_objets_relatifs">'
    write '=== MÉTADONNÉES ===', nil, {div_class: 'titre'}
    collecte.metadata.data.each do |prop, valu|
      valu != nil || next
      # Modification de certaines valeurs
      valu =
        case prop
        when :auteurs
          valu.pretty_join
        else valu
        end
      write prop, valu
    end
    write '</metadata>'
    final_file.flush
  end
  # /extract_meta_data

  def extract_personnages_data
    write '<personnages class="liste_objets_relatifs">'
    write '=== PERSONNAGES ===', nil, {div_class: 'titre'}
    film.personnages.each do |perso_id, perso|
      write "Personnage #{perso.id}", nil, {div_class: 'stitre'}
      Film::Personnage::PROPERTIES.each do |prop|
        write "#{prop}", "#{perso.send(prop)}"
      end
    end
    write '</personnages>'
    final_file.flush
  end
  # /extract_personnages_data


  def extract_brins_data
    write '<brins class="liste_objets_relatifs">'
    write '=== BRINS ===', nil, {div_class: 'titre'}
    film.brins.each do |brin_id, brin|
      write "Brin #{brin_id}", nil, {div_class: 'stitre'}
      [:id, :libelle, :description].each do |prop|
        write "#{prop}", "#{brin.send(prop)}"
      end
    end
    write '</brins>'
    final_file.flush
  end
  # /extract_brins_data

  def as_string_value value
    case value
    when Hash
      value.to_json
    when Array
      value.join(',')
    when Film::Horloge
      value.horloge
    when Film::TextObjet
      value.hash_data
      # Retourne un Hash
    else
      value.to_s
    end
  end

  def extract_scenes_data
    write '<scenes class="liste_objets_relatifs">'
    write '=== SCENES ===', nil, {div_class: 'titre'}
    film.scenes.each do |scene_id, scene|
      write "Scene #{scene.numero}", nil, {div_class: 'stitre'}
      Film::Scene::PROPERTIES.each do |prop, dprop|
        # Traitement de la valeur en fonction de sa
        # classe.
        value = as_string_value(scene.send(prop))
        # Traitement en fonction de la valeur
        # finale (une valeur string, un nil, ou un hash)
        case value
        when NilClass
          next
        when Hash
          value.each do |k,v|
            write "#{k}", "#{as_string_value(v)}"
          end
          next
        end
        write "#{prop}", "#{value}"
      end

      # Sauvegarde des paragraphes de la scène
      (scene.paragraphes|[]).each_with_index do |paragraphe, i|
        write "Paragraphe #{i}", nil, {div_class: 'stitre'}
        paragraphe.hash_data.each do |prop, valeur|
          write "#{prop}", "#{valeur}"
        end
      end
    end
    write '</scenes>'
    final_file.flush
  end
  # /extract_scenes_data

end #/Extractor
end #/Collecte
