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
    @options = default_options(options)
    final_file.options= @options

    # Requérir le dossier correspondant au format
    require_folder File.join(MAIN_FOLDER,'module',"extract_formats", "#{format.to_s.upcase}")

    final_file.prepare || return

    case options[:as]
    when :outline, :sequencier
      extract_data_as_sequencier
    else # ou :whole
      # Sans précision du format de sortie voulu
      extract_data_as_whole
    end

    final_file.finalise || return

    # S'il faut ouvrir le fichier à la fin
    if options[:open_file]
      `open "#{final_file.path}"`
    else
      puts "#{RC}#{RC}=== Extraction effectuée avec succès ===#{RC}#{RC}"
    end

  end

  def extract_data_as_sequencier
    extract_sequencier
  end
  def extract_data_as_whole
    extract_meta_data
    extract_personnages_data
    extract_brins_data
    extract_scenes_data
  end

  def default_options opts
    opts ||= Hash.new
    opts.key?(:format)    || opts.merge!(format: format)
    opts.key?(:open_file) || opts.merge!(open_file: false)
    opts.key?(:full_file) || opts.merge!(full_file: true)
    opts.key?(:as)        || opts.merge!(as: :whole)
    opts[:as] != :outline || opts[:as] = :sequencier

    return opts
  end

end #/Extractor
end #/Collect
