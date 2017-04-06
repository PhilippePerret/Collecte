# encoding: UTF-8
#
# Méthodes permettant d'extraire les données collectées
#
class Collecte
class Extractor

  # Pour les options, cf. le fichier RefBook/Extraction/Options.md
  def extract_data options = nil
    options = default_options(options)

    prepare_file || return

    extract_meta_data

    extract_personnages_data

    extract_brins_data

    extract_scenes_data

    # S'il faut ouvrir le fichier à la fin
    if options[:open_file]
      `open "#{path}"`
    else
      puts "#{RC}#{RC}=== Extraction effectuée avec succès ===#{RC}#{RC}"
    end
  end

  def default_options opts
    opts ||= Hash.new
    opts.key?(:open_file) || opts.merge!(open_file: false)
    return opts
  end

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
    flush_file_content
  end

  def extract_personnages_data
    write "#{format == :text ? RC*2 : ''}=== PERSONNAGES ==="
    film.personnages.each do |perso_id, perso|
      write "#{format == :text ? RC : ''}Personnage #{perso.id}"
      Film::Personnage::PROPERTIES.each do |prop|
        write "#{prop}", "#{perso.send(prop)}", {before_label: "\t"}
      end
    end
    flush_file_content
  end

  def extract_brins_data
    write "#{format == :text ? RC*2 : ''}=== BRINS ==="
    film.brins.each do |brin_id, brin|
      write "#{format == :text ? RC : ''}Brin #{brin_id}"
      [:id, :libelle, :description].each do |prop|
        write "#{prop}", "#{brin.send(prop)}", {before_label: "\t"}
      end
    end
    flush_file_content
  end

  def extract_scenes_data
    write RC*2 + '=== SCENES ==='
    film.scenes.each do |scene_id, scene|
      write "#{format == :text ? RC : ''}Scene #{scene.numero}"
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
        paragraphe.hash_data.each do |prop, valeur|
          write "#{prop}", "#{valeur}", {before_label: "\t\t"}
        end
      end
    end
    flush_file_content
  end

end #/Extractor
end #/Collect
