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
    if format == :html
      set_javascripts_by_type
      set_css_by_type
    end
  end

  # Le titre (balise title en HTML + div) en fonction
  # des options.
  def set_title
    if options[:as] == :brin
      tit = Film::Brin.titre_with_options(options)
    else
      tit =
        case options[:as]
        when :brin
          # Les brins ont des titres complexes traités
          # ci-dessus
        when :sequencier
          "Séquencier"
        when :synopsis
          "Synopsis"
        when :resume
          "Résumé"
        when :statistiques
          "Fichier statistiques"
        else
          "Extraction des données du #{collecte.extractor.date}"
        end
      if options[:from_time] || options[:to_time]
        hfrom = (options[:from_time]||0).s2h
        hto   = (options[:to_time]||film.duree).s2h
        tit << " partiel (#{hfrom} à #{hto})"
      else
        tit << ' complet'
      end
      # S'il y a un titre de film défini, on l'ajoute à la fin
      # du titre
      film.titre && tit << " du film “#{film.titre}”"
    end
    # Pour le moment, la balise title et le titre du
    # document sont identiques.
    final_file.title        = tit
    final_file.titre_final  = tit
  end

  def set_javascripts_by_type
    js_files = Array.new
    case options[:as]
    when :sequencier, :synopsis, :brin, :statistiques
      js_files << "#{folder_js}/fiches.js"
    when :resume
      # Rien du tout
    end
    js_files.empty? || final_file.javascript_files = js_files
  end

  def set_css_by_type
    final_file.css_files =
      case options[:as]
      when :sequencier, :brin
        ["#{folder_css}/sequencier.css"]
      when :synopsis
        ["#{folder_css}/synopsis.css"]
      when :resume
        ["#{folder_css}/resume.css"]
      when :statistiques
        ["#{folder_css}/statistiques.css"]
      else
        # Rien du tout
        nil
      end
  end

  def set_file_affixe
    af =
      case options[:as]
      when :sequencier
        af = 'sequencier'
        options[:suggest_structure] && af << "_suggest_stt"
        af
      when :resume
        'resume'
      when :synopsis
        'synopsis'
      when :brin
        "brin_#{options[:filter][:brins].gsub(/[\(\),\+]/,'_').gsub(/ /,'')}"
      when :statistiques
        'statistiques'
      else
        'extract_data'
      end
    af = add_from_to_to_affixe(af)
    # On donne l'affixe au fichier final
    final_file.faffixe = af
  end


  # Méthode d'extraction appelée par extract_data
  def call_extract_methode_by_type

    methode_name = "extract_#{options[:as]}".to_sym
    log "Méthode d'extraction à utiliser : #{methode_name.inspect}"

    if respond_to?(methode_name)
      send(methode_name)
    else
      # Sans précision de format
      extract_data_as_whole
    end
  end


  def add_from_to_to_affixe aff
    if options[:from_time] || options[:to_time]
      options[:from_time] && aff << "_from_#{options[:from_time]}"
      options[:to_time]   && aff << "_to_#{options[:to_time]}"
    elsif options[:as] != :resume
      aff = "full_#{aff}"
    end
    return aff
  end

end #/Extractor
end #/Collect
