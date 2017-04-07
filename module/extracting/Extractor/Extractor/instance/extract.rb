# encoding: UTF-8
#
# Méthodes permettant d'extraire les données collectées
#
class Collecte
class Extractor

  # Pour les options, cf. le fichier RefBook/Extraction/Options.md
  # Pour travailler, la méthode charge le module
  # de `./module/extract_formats` correspondant au format.
  def extract_data options = nil
    options = default_options(options)

    # Requérir le dossier correspondant au format
    require_folder File.join(MAIN_FOLDER,'module',"extract_formats", "#{format.to_s.upcase}")

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

end #/Extractor
end #/Collect
