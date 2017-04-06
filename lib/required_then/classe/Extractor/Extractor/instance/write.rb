# encoding: UTF-8
class Collecte
class Extractor

  # Méthode principale d'écriture dans le fichier
  # d'extration.
  def write label, valeur, options = nil
    line_extract =
      case format
      when :html
        '<div class="">'+
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
