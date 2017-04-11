# encoding: UTF-8
#
# L'idée est de rassembler dans cet unique module toutes
# les méthodes qui permettent de définir des choses
# différentes en fonction du type de document produit.
#
class Collecte
class Extractor

  # Définit tous les éléments, titre, nom du fichier,
  # etc. en fonction du type de document produit,
  # séquencier, synopsis ou autre
  def set_by_type
    set_title
    set_file_affixe
  end

  # Le titre (balise title en HTML + div) en fonction
  # des options.
  def set_title
    tit =
      case options[:as]
      when :brin
        "Brin #{options[:filter][:brins].gsub(/[\(\),\+]/,' ')}"
      when :sequencier
        "Séquencier"
      when :synopsis
        "Synopsis"
      else
        "Extraction des données du #{collecte.extractor.date}"
      end
    if options[:from_time] || options[:to_time]
      tit << ' partiel'
    else
      tit << ' complet'
    end
    # S'il y a un titre de film défini, on l'ajoute à la fin
    # du titre
    if film.titre
      tit << " du film “#{film.titre}”"
    end
    # Pour le moment, la balise title et le titre du
    # document sont identiques.
    final_file.title        = tit
    final_file.titre_final  = tit
  end

  def set_file_affixe
    af =
      case options[:as]
      when :sequencier
        af = 'sequencier'
        options[:suggest_structure] && af << "_suggest_stt"
        af
      when :synopsis
        'synopsis'
      when :brin
        "brin_#{options[:filter][:brins].gsub(/[\(\),\+]/,'_').gsub(/ /,'')}"
      else
        'extract_data'
      end
    af = add_from_to_to_affixe(af)
    # On donne l'affixe au fichier final
    final_file.faffixe = af
  end
  def add_from_to_to_affixe aff
    if options[:from_time] || options[:to_time]
      options[:from_time] && aff << "_from_#{options[:from_time]}"
      options[:to_time]   && aff << "_to_#{options[:to_time]}"
    else
      aff = "full_#{aff}"
    end
    return aff
  end

end #/Extractor
end #/Collect
