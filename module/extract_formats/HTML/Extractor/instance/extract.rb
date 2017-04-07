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

    titre = "Séquencier du film “#{film.titre}”"
    final_file.title = titre # balise title
    write div(titre, id: 'titre')
    write '<section id="sequencier" class="scenes">'
    from_time = options[:from_time] || 0
    to_time   = options[:to_time]   || 100*3600
    film.scenes.each do |scene_id, scene|
      scene.time >= from_time || next
      scene.time <= to_time   || next
      # La scène doit être prise
      write scene.as_sequence
    end
    write '</section>'

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
