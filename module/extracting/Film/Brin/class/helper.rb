# encoding: UTF-8
class Film
class Brin
class << self

  attr_reader :options

  def init
    @film = nil
  end

  def film
    @film ||= Collecte.current.film
  end

  # Retourne le titre du brin avec les options
  # +options+
  # Note : la méthode appelante ajoutera encore le
  # titre ou le suffixe "complet"
  def titre_with_options options
    @options = options
    filtre_brins = options[:filter][:brins]
    filtre_brins.instance_of?(Array) || begin
      filtre_brins = filtre_brins.as_filter_str_to_array
    end
    allbrins = Array.new
    liste_ids =
      filtre_brins.collect do |arr|
        arr.each do |bid|
          allbrins << {id: bid, titre: film.brins[bid].libelle.to_html}
        end
        if arr.count > 1
          "(#{arr.join(' OU ')})"
        else
          arr.first.to_s
        end
      end.join(' ET ')

    plusieurs_brins = allbrins.count > 1

    s = plusieurs_brins ? 's' : ''
    liste_ids.match(/^\((.*?)\)$/) && liste_ids = liste_ids[1..-2]
    tit = "Brin#{s} #{liste_ids}"

    plusieurs_brins || tit << " (#{allbrins.first[:titre]})"

    if options[:from_time] || options[:to_time]
      hfrom = (options[:from_time]||0).s2h
      hto   = (options[:to_time]||film.duree).s2h
      tit << " partiel#{s} (#{hfrom} à #{hto})"
    else
      tit << " complet#{s}"
    end
    film.titre && tit << " du film “#{film.titre}”"

    case options[:format]
    when :text, :xml
    else
      Collecte.require_module 'html_methods'
      if plusieurs_brins
        allbrins.each do |hbrin|
          tit << div("#{hbrin[:id]} : #{hbrin[:titre]}", class: 'lib_brin')
        end
      end
    end
    return tit
  end

end #/<< self
end #/ Brin
end #/ Film
