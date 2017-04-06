# encoding: UTF-8
class Collecte
class Extractor

  # Méthode principale d'écriture dans le fichier
  # d'extration.
  #
  # +options+
  #   :before_label     Texte à mettre avant le label
  def write label, valeur = nil, options = nil
    options ||= Hash.new

    label = "#{options[:before_label]}#{label}"

    line_extract =
      if valeur.nil?
        case format
        when :html then "<div>#{label}</div>"
        else label
        end
      else
        case format
        when :html
          '<div class=\'libval\'>'+
            html_span_label(label)+
            html_span_value(valeur)+
          '</div>'
        when :text
          "#{label} :".ljust(24) + valeur.to_s
        when :xml
          '<data>' +
            "<label>#{label}</label>"+
            "<value>#{valeur}</value>"+
          '</data>'
        else
          raise "Le format #{format} est inconnu pour l'extraction."
        end
      end
    # On ajoute cette donnée au contenu complet du fichier
    @file_content << (line_extract + RC)
  end

  def html_span_label label
    "<span class='label'>#{label}</span>"
  end
  def html_span_value value
    "<span class='value'>#{value}</span>"
  end

end #/Extractor
end #/Collect
