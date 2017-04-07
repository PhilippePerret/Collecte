# encoding: UTF-8
#
# Méthodes d'extraction des données propres au format
# HTML
#
Collecte.require_module 'html_methods'
class Collecte
class Extractor

  def extract_meta_data
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
    final_file.flush
  end
  # /extract_meta_data

  def extract_personnages_data
    write '<personnages class="liste_objets_relatifs">'
    write '=== PERSONNAGES ===', nil, {span_class: 'titre'}
    film.personnages.each do |perso_id, perso|
      write "Personnage #{perso.id}"
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
    write '=== BRINS ===', nil, {span_class: 'titre'}
    film.brins.each do |brin_id, brin|
      write "Brin #{brin_id}"
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
    write '=== SCENES ===', nil, {span_class: 'titre'}
    film.scenes.each do |scene_id, scene|
      write "Scene #{scene.numero}"
      Film::Scene::PROPERTIES.each do |prop, dprop|
        value =
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
        write div("Paragraphe #{i}")
        paragraphe.hash_data.each do |prop, valeur|
          write "#{prop}", "#{valeur}"
        end
      end
      write '</scenes>'
    end
    final_file.flush
  end
  # /extract_scenes_data

end #/Extractor
end #/Collecte
