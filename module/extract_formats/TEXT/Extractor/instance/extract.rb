# encoding: UTF-8
#
# Méthodes d'extraction des données propres au format
# TEXT
#
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

  def extract_personnages_data
    write RC*2 + '=== PERSONNAGES ==='
    film.personnages.each do |perso_id, perso|
      write "#{RC}Personnage #{perso.id}"
      Film::Personnage::PROPERTIES.each do |prop|
        write "#{prop}", "#{perso.send(prop)}", {before_label: "\t"}
      end
    end
    final_file.flush
  end
  # /extract_personnages_data

  def extract_brins_data
    write RC*2 + '=== BRINS ==='
    film.brins.each do |brin_id, brin|
      write "#{RC}Brin #{brin_id}"
      write "id", "#{brin.id}", {before_label: "\t"}
      [:libelle, :description].each do |prop|
        write "#{prop}", "#{brin.send(prop).to_html}", {before_label: "\t"}
      end
    end
    final_file.flush
  end
  # /extract_brins_data

  def extract_decors_data
    write RC*2 + '=== DÉCORS ==='
    film.decors.each do |decor_id, decor|
      write "#{RC}Scene #{decor.id}"
      Film::Decor::PROPERTIES.each do |prop, dprop|
        val_init = decor.send(prop)
        if val_init != nil && dprop[:value]
          if dprop[:args]
            val_init = val_init.send(dprop[:value], dprop[:args])
          else
            val_init = val_init.send(dprop[:value])
          end
        end
        write "#{prop}", "#{val_init}", {before_label: "\t"}
      end
    end
    final_file.flush
  end
  # /extract_decors_data

  def extract_scenes_data
    write RC*2 + '=== SCENES ==='
    film.scenes.each do |scene_id, scene|
      write "#{RC}Scene #{scene.numero}"
      Film::Scene::PROPERTIES.each do |prop, dprop|
        val_init = scene.send(prop)
        if val_init != nil && dprop[:value]
          if dprop[:args]
            val_init = val_init.send(dprop[:value], dprop[:args])
          else
            val_init = val_init.send(dprop[:value])
          end
        end
        write "#{prop}", "#{val_init}", {before_label: "\t"}
      end

      # Sauvegarde des paragraphes de la scène
      (scene.paragraphes|[]).each_with_index do |paragraphe, i|
        write "\tParagraphe #{i}"
        paragraphe.to_hash.each do |prop, valeur|
          write "#{prop}", "#{valeur}", {before_label: "\t\t"}
        end
      end
    end
    final_file.flush
  end
  # /extract_scenes_data

end #/Extractor
end #/Collecte
