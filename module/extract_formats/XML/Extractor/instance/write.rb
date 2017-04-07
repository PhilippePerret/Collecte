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
        label
      else
        <<-EOT
        <data>
          <label>#{label}</label>
          <value>#{value}</value>
        </data>
        EOT
      end
    # On ajoute cette donnée au contenu complet du fichier
    final_file << (line_extract + RC)
  end

end #/Extractor
end #/Collect
