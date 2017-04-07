# encoding: UTF-8
class Collecte
class Extractor

  def write label, valeur = nil, options = nil
    options ||= Hash.new

    label = "#{options[:before_label]}#{label}"

    line_extract =
      if valeur.nil?
        label
      else
        "#{label}".ljust(24) + valeur.to_s
      end
    # On ajoute cette donnée au contenu complet du fichier
    final_file << (line_extract + RC)
  end

end #/Extractor
end #/Collect
