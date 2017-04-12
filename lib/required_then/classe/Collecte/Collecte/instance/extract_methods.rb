# encoding: UTF-8
class Collecte

  # = main =
  #
  # Méthode principale appelée pour extraire les
  # données collectées
  # +options+   Défini les options
  # +options_alt+ Lorsque +options+ est un raccourci-symbol,
  # on peut mettre dans +options_alt+ les options habituelles
  def extract options = nil, options_alt = nil
    options = options_arg_to_real_options(options)
    options_alt.nil? || options.merge!(options_alt)
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
    case opts
    when Hash
      opts
    when Symbol
      case opts
      when :sequencier_html
        {format: :html, as: :sequencier}
      when :sequencier
        {format: :text, as: :sequencier}
      when :all_brins_html
        {format: :html, as: :all_brins}
      else
        raise "L'argument `#{opts.inspect}` transmis à #extract n'est pas connu."
      end
    else
      raise "L'argument transmis à #extract devrait être un Hash ou un Symbol (c'est un #{opts.class})."
    end
  end
end
