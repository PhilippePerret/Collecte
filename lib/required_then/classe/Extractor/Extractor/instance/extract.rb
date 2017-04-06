# encoding: UTF-8
#
# Méthodes permettant d'extraire les données collectées
#
class Collecte
class Extractor

  # Pour les options, cf. le fichier RefBook/Extraction/Options.md
  def extract_data options

    @format = options[:format]

    prepare_file || return

    extract_meta_data

    extract_scenes_data

    extract_personnages_data

    extract_brins_data

    # S'il faut ouvrir le fichier à la fin
    if options[:open_file]
      `open "#{path}"`
    else
      puts "#{RC}#{RC}=== Extraction effectuée avec succès ===#{RC}#{RC}"
    end
  end

  def extract_meta_data
    collecte.metadata.data.each do |prop, valu|
      write prop, valu
    end
    flush_file_content
  end
  def extract_scenes_data

    flush_file_content
  end
  def extract_personnages_data

    flush_file_content
  end
  def extract_brins_data

    flush_file_content
  end

end #/Extractor
end #/Collect
