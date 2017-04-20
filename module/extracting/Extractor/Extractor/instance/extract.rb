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
    log "-> extract_data(options = #{options.inspect})"
    @options = default_options(options)

    if @options[:as] == :all
      #
      # Option particulière :all qui permet d'extraire
      # tous les fichiers possibles
      #
      log "*** Extraction de tous les fichiers possibles ***"
      options_init = @options.dup
      # On boucle sur tous les fichiers possibles
      [
        {as: :sequencier},
        {as: :sequencier, suggest_structure: true},
        {as: :resume},
        {as: :synopsis},
        {as: :statistiques}
      ].each do |hextraction|
        @options = options_init.merge( hextraction )
        log "Proceed extract data avec @options = #{@options.inspect}"
        proceed_extract_data
      end
      # Pour le fichier de tous les brins, il faut rappeler
      # cette méthode
      return extract_data(@options.merge(as: :all_brins))
    elsif @options[:as].to_s.start_with?('all_')
      as_splited = @options[:as].to_s.split('_')
      objet = as_splited[1]
      @options[:format] = (as_splited[2] || @options[:format] || 'html').to_sym
      log "*** Traitement d'un ensemble d'objets #{objet} ***"
      case objet
      when 'brins'
        @options[:as] = :brin
        @options.key?(:filter) || @options.merge!(filter: Hash.new)
        #
        # Traitement des brins définis en tant que tels
        #
        film.brins.each do |brin_id, brin|
          log ''
          log "* Traitement de l'objet brin ##{brin_id}"
          @options[:filter][:brins] = brin_id.to_s
          proceed_extract_data
        end
        #
        # Traitement des brins par personnages
        #
        film.personnages.each do |perso_id, perso|
          log ''
          log "* Traitement du brin personnage #{perso.pseudo}"
          @options.merge!(
            as:         :brin_personnage,
            personnage: perso
          )
          proceed_extract_data
        end
        #
        # Traitement des brins de type "relation entre personnages"
        #
        film.relations_personnages.each do |rel_id, relation|
          log ''
          log "* Traitement du brin #{relation.to_str}"
          @options.merge!(
            as:         :brin_relation,
            relation:   relation
          )
          proceed_extract_data
        end
      end
    else
      proceed_extract_data
    end
  end


  def proceed_extract_data

    # On initialise l'extracteur, ce qui est fondamental surtout
    # lorsque des fichiers de type différent sont demandés
    init

    # On passe les options aux classes qui en ont
    # besoin
    Film::Scene.options_extraction = options

    # On définit tous les éléments en fonction du type
    # de document produit (séquencier, brin, etc.) et des
    # filtres et options choisis
    set_by_type

    # Requérir le dossier correspondant au format
    require_folder File.join(MAIN_FOLDER,'module','extract_formats', "#{format.to_s.upcase}")

    # Reset (pour les tests, surtout)
    Film::TextObjet.init if format == :html
    Film::RelationPersonnage.init
    Film::Personnage.init
    Film::Brin.init
    Film::Decor.init

    final_file.prepare || return

    # Préparer le filtre si nécessaire
    options.key?(:filter) && analyze_filter

    # Pour que tout soit mis dans set_by_type,
    # on appelle la méthode utilise depuis là.
    call_extract_methode_by_type

    # Finalisation du fichier final
    final_file.finalise || return

    # S'il faut ouvrir le fichier à la fin
    Collecte.mode_test? || begin
      if options[:open_file]
        `open "#{final_file.path}"`
      else
        puts "#{RC}#{RC}=== Extraction effectuée avec succès ===#{RC}#{RC}"
      end
    end
  end

  def extract_data_as_whole
    extract_meta_data
    extract_personnages_data
    extract_brins_data
    extract_scenes_data
    extract_decors_data
  end

  def default_options opts
    opts ||= Hash.new
    opts.key?(:format)    || opts.merge!(format: format)
    opts.key?(:open_file) || opts.merge!(open_file: false)
    opts.key?(:full_file) || opts.merge!(full_file: true)

    case opts[:as]
    when NilClass
      if opts[:all]
        opts.merge!(as: :all)
        opts.delete(:all)
      else
        opts.merge!(as: :whole)
      end
    when :brin
      if opts.key?(:brin) || opts.key?(:brins)
        opts.key?(:filter) || opts.merge!(filter: Hash.new)
        opts[:filter].merge!(brins: (opts.delete(:brin)||opts.delete(:brins)).to_s)
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
