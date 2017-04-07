# encoding: UTF-8
class Collecte
class Extractor

  # Méthode principale d'écriture dans le fichier
  # d'extration.
  #
  # +options+
  #   :before_label     Texte à mettre avant le label
  #   :class_span       {String} La classe à donner au span
  # 
  def write label, valeur = nil, options = nil
    options ||= Hash.new

    label = "#{options[:before_label]}#{label}"

    line_extract =
      if valeur.nil?
        if options[:span_class]
          span(label, {class: options[:span_class]})
        elsif options[:div_class]
          div(label, {class: options[:div_class]})
        else
          div(label)
        end
      else
        div(
          span(label, class: 'label') +
          span(valeur, class: 'value'),
          {class: 'libval'}
        )
      end
    # On ajoute cette donnée au contenu complet du fichier
    final_file << (line_extract + RC)
  end

end #/Extractor
end #/Collect
