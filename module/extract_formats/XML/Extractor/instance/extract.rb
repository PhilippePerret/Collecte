# encoding: UTF-8
#
# Méthodes d'extraction des données propres au format
# HTML
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
    write '<personnages>'
    film.personnages.each do |perso_id, perso|
      write '<personnage>'
      Film::Personnage::PROPERTIES.each do |prop|
        write "#{prop}", "#{perso.send(prop)}"
      end
      write '</personnage>'
    end
    write '</personnages>'
    final_file.flush
  end
  #/extract_personnages_data

  def extract_brins_data
    write '<brins>'
    film.brins.each do |brin_id, brin|
      write "\t<brin id=\"#{brin_id}\">"
      [:id, :libelle, :description].each do |prop|
        write "#{prop}", "#{brin.send(prop)}"
      end
      write "\t</brin>"
    end
    write '</brins>'
    final_file.flush
  end

  def extract_scenes_data
    write '<scenes>'
    film.scenes.each do |scene_id, scene|
      write "\t<scene id=\"#{scene_id}\">"
      Film::Scene::PROPERTIES.each do |prop, dprop|
        val_init = scene.send(prop)
        if val_init != nil && dprop[:value]
          if dprop[:args]
            val_init = val_init.send(dprop[:value], dprop[:args])
          else
            val_init = val_init.send(dprop[:value])
          end
        end
        write "#{prop}", "#{val_init}"
      end

      # Sauvegarde des paragraphes de la scène
      write "\t\t<paragraphes>"
      (scene.paragraphes|[]).each_with_index do |paragraphe, i|
        write "\t\t\t<paragraphe id=\"#{i}\">"
        paragraphe.hash_data.each do |prop, valeur|
          write "#{prop}", "#{valeur}"
        end
        write "\t\t\t</paragraphes>"
      end
      write "\t\t</paragraphes>"
      write "\t</scene>"
    end
    write '</scenes>'
    final_file.flush
  end

end #/Extractor
end #/Collecte
