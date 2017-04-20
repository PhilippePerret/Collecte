# encoding: UTF-8
#
# Méthodes d'extraction des données propres au format
# HTML
#
Collecte.require_module 'html_methods'
class Collecte
class Extractor

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
    log "-> extract_brins_data (HTML)"
    write '<brins class="liste_objets_relatifs">'
    write '=== BRINS ===', nil, {div_class: 'titre'}
    film.brins.each do |brin_id, brin|
      write "Brin #{brin_id}", nil, {div_class: 'stitre'}
      write "id", brin.id
      [:libelle, :description].each do |prop|
        write "#{prop}", brin.send(prop).to_html
      end
    end
    write '</brins>'
    log "<- extract_brins_data (HTML)"
    final_file.flush
  end
  # /extract_brins_data

  # Traitement de la valeur +value+ en fonction de sa
  # classe
  # Traitement en fonction de la valeur
  # finale (une valeur string, un nil, ou un hash)
  def treate_per_value prop, value
    value.instance_of?(Film::TextObjet) && value = value.to_hash

    case value
    when NilClass
      return
    when Hash
      value.each do |k,v|
        treate_per_value(k, v)
      end
      return
    when Film::Horloge
      value = value.horloge
    else
      as_string_value(value)
    end

    write "#{prop}", "#{value}"
  end

  def as_string_value value
    case value
    when Hash
      value.to_json
    when Array
      value.join(',')
    else
      value.to_s
    end
  end

  def extract_decors_data
    log "-> extract_decors_data (HTML)"
    log "   Nombre de décors : #{film.decors.count}"
    write '<decors class="liste_objets_relatifs">'
    write '=== DÉCORS ===', nil, {div_class: 'titre'}
    film.decors.each do |decor_id, decor|
      write "Décor #{decor_id}", nil, {div_class: 'stitre'}
      Film::Decor::PROPERTIES.each do |prop, dprop|
        treate_per_value prop, decor.send(prop)
      end
    end
    write '</decors>'
    log "<- extract_decors_data (HTML)"
    final_file.flush
  end
  # /extract_decors_data

  def extract_scenes_data
    log "-> extract_scenes_data (HTML)"
    write '<scenes class="liste_objets_relatifs">'
    write '=== SCENES ===', nil, {div_class: 'titre'}
    film.scenes.each do |scene_id, scene|
      write "Scene #{scene.numero}", nil, {div_class: 'stitre'}
      Film::Scene::PROPERTIES.each do |prop, dprop|
        value = scene.send(prop)
        treate_per_value prop, value
      end

      # Sauvegarde des paragraphes de la scène
      (scene.paragraphes|[]).each_with_index do |paragraphe, i|
        write "Paragraphe #{i}", nil, {div_class: 'stitre'}
        paragraphe.to_hash.each do |prop, valeur|
          write "#{prop}", "#{valeur}"
        end
      end
    end
    write '</scenes>'
    log "<- extract_scenes_data (HTML)"
    final_file.flush
  end
  # /extract_scenes_data

end #/Extractor
end #/Collecte
