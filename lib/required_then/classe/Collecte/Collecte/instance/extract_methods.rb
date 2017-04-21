# encoding: UTF-8
class Collecte

  # = main =
  #
  # Méthode principale appelée pour extraire les
  # données collectées
  # +options+   Défini les options
  # +options_alt+ Lorsque +options+ est un raccourci-symbol,
  # on peut mettre dans +options_alt+ les options habituelles
  # 
  def extract options = nil, options_alt = nil
    log "Collecte#extract(options:#{options.inspect}, options_alt:#{options_alt.inspect})"
    options = options_arg_to_real_options(options)
    options_alt.nil? || options.merge!(options_alt)
    log "   options finales: #{options.inspect}"

    # Faut-il parser les fichiers avant l'opération
    # d'extraction ?
    options[:force_parsing].nil? || parse(options)

    # On procède à l'extraction
    extractor(options.delete(:format)).extract_data(options)
  ensure
    if (errors != nil && errors.count > 0) || options[:debug]
      Log.build_and_open_html_file
    end
  end

  # La méthode principale Collecte#extract peut recevoir
  # un Hash définissant toutes les valeurs, mais aussi un
  # simple Symbol pour traiter rapidement certaines choses
  # Par exemple : `:sequencier_html`
  # Cette méthode permet de convertir ce symbol en un hash
  # correct
  def options_arg_to_real_options opts
    if opts.to_s.match(/_(html|text|xml)$/)
      arr_opts = opts.to_s.split('_')
      fmt = arr_opts.pop.to_sym
      as  = arr_opts.join('_').to_sym
      return {format: fmt, as: as}
    end
    case opts
    when Hash
      opts
    when Symbol
      case opts
      when :sequencier
        {format: :text, as: :sequencier}
      else
        raise "L'argument `#{opts.inspect}` transmis à #extract n'est pas connu."
      end
    else
      raise "L'argument transmis à #extract devrait être un Hash ou un Symbol (c'est un #{opts.class})."
    end
  end
end
