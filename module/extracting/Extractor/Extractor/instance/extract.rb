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
    write RC*2 + '=== PERSONNAGES ==='
    film.personnages.each do |perso_id, perso|
      write "#{RC}Personnage #{perso.id}"
      Film::Personnage::PROPERTIES.each do |prop|
        write "#{prop}", "#{perso.send(prop)}", {before_label: "\t"}
      end
    end
    flush_file_content
  end

  def extract_brins_data
    write RC*2 + '=== BRINS ==='

    flush_file_content
  end

  def extract_scenes_data
    write RC*2 + '=== SCENES ==='

    flush_file_content
  end

end #/Extractor
end #/Collect
