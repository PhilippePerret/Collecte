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

    if @options[:as].to_s.start_with?('all_')
      objet = @options[:as].to_s.split('_')[1]
      log "Traitement d'un ensemble d'objets #{objet}"
      case objet
      when 'brins'
        @options[:as] = :brin
        @options.key?(:filter) || @options.merge!(filter: Hash.new)
        film.brins.each do |brin_id, brin|
          log "\tTraitement de l'objet Brin ##{brin_id}"
          init # pour forcer les recalculs
          @options[:filter][:brins] = brin_id.to_s
          proceed_extract_data
        end
      end
    else
      proceed_extract_data
    end
  end


  def proceed_extract_data
    # On passe les options aux classes qui en ont
    # besoin
    Film::Scene.options_extraction = options

    # On construit le titre final en fonction des options
    # Il faut le faire maintenant, parce que ce titre dépend des
    # options, et notamment du filtre, et dans ce filtre, les
    # valeurs string seront remplacées par des processus.
    final_file.titre_final

    # Requérir le dossier correspondant au format
    require_folder File.join(MAIN_FOLDER,'module','extract_formats', "#{format.to_s.upcase}")

    final_file.prepare || return

    # Préparer le filtre si nécessaire
    options.key?(:filter) && analyze_filter

    case options[:as]
    when :sequencier, :brin
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

    case opts[:as]
    when NilClass
      opts.merge!(as: :whole)
    when :brin
      if opts.key?(:brin)
        opts.key?(:filter) || opts.merge!(filter: Hash.new)
        opts[:filter].merge!(brins: opts.delete(:brin).to_s)
      end
    when :outline
      opts.merge!(as: :sequencier)
    end

    # Les temps sont transformés en secondes
    [:from_time, :to_time].each do |prop|
      if opts.key?(prop) && opts[prop].instance_of?(String)
        opts[prop] = opts[prop].h2s
      end
    end

    return opts
  end

end #/Extractor
end #/Collect
