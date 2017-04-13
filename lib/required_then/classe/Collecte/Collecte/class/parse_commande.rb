class Collecte
class << self

  # la commande demandée (tout de suite après `collecte`)
  attr_reader :command
  # Les options relevées dans la ligne de commande
  attr_reader :command_options
  # Le dossier de collecte, soit précisé explicitement,
  # soit implicitement, le dossier depuis lequel est
  # appelée la commande.
  attr_reader :command_folder

  SHORT_OPTIONS_TO_LONG = {
    'b'     => :brins,
    'd'     => :debug,
    'h'     => :horloge,
    'o'     => :output_format,
    'seq'   => :sequencier,
    'syn'   => :synopsis,
    'stats' => :statistiques,
    'fp'    => :force_parsing,
    'v'     => :verbose,
    'stt'   => :suggest_structure,
    'open'  => :open_file
  }

  # = main =
  #
  # Méthode qui analyse la commande. Elle définit
  # la commande principale (:help, :parse ou :extract)
  #
  def parse_commande
    log "-> Collecte::parse_commande"
    log "Analyse de la ligne de commande"
    @command          = ARGV.shift
    @command_options  = Hash.new
    @command_folder   = nil
    ARGV.each do |arg|
      case arg
      when /^\-\-/
        option, value = arg[2..-1].split('=')
        value = value.nil_if_empty || true
        # log "Option #{option.inspect} mise à #{value.inspect}"
        if ['html', 'xml', 'text'].include? option
          @command_options.merge!(:output_format => option.to_sym)
        else
          @command_options.merge!(option.to_sym => value)
        end
      when /^\-/
        option, value = arg[1..-1].split('=')
        value = value.nil_if_empty || true
        # log "Option #{option.inspect} mise à #{value.inspect}"
        @command_options.merge!(SHORT_OPTIONS_TO_LONG[option] => value)
      else
        @command_folder.nil? || begin
          raise "Le dossier collecte est déjà défini. La donnée #{arg} est superfétatoire."
        end
        @command_folder = arg
      end
    end

    # Valeurs par défaut
    @command_options[:output_format] ||= :html

    # Les options qui seront passés à la commande
    opts = Hash.new
    command_options.each do |kopt, value|
      case kopt
      when :synopsis
        log "Extraction du synopsis"
        opts.merge!(as: :synopsis)
        command_options['horloge'] && opts.merge!(horloge: true)
      when :sequencier
        log "Extraction du séquencier"
        opts.merge!(as: :sequencier)
      when :brins
        log "Extraction des brins"
        opts.merge!(as: :brins)
      when :statistiques
        log "Extraction des statistiques"
        opts.merge!(as: :statistiques)
      when :from
        log "Temps de départ : #{value}"
        opts.merge!(from_time: value.h2s)
      when :to
        log "Temps de fin : #{value}"
        opts.merge!(to_time: value.h2s)
      when :output_format
        log "Format de sortie : #{value.inspect}"
        opts.merge!(format: value)
      else
        # Pour toutes les autres valeurs
        log "Option #{kopt.inspect} mise à #{value.inspect}"
        opts.merge!(kopt => value)
      end
    end
    # On passe les bonnes options dans la variable de classe
    # qui sera transmise aux commandes `parse` ou `extract`
    @command_options = opts
    log "<- Collecte::parse_commande"
  end

end #/<< self
end #/Collecte
