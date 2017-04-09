# encoding: UTF-8
class Collecte

  # = main =
  #
  # Méthode principale appelée pour extraire les
  # données collectées
  def extract options = nil
    options = options_arg_to_real_options(options)
    extractor(options.delete(:format)).extract_data(options)
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
