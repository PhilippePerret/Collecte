# encoding: UTF-8
class Film
class Structure
class Point


  def zone_pfa_h de = nil, to = nil
    (exist? && debut) || return
    de ||= ''
    to ||= 'à'
    "#{de} #{zone_pfa.debut.s2h} #{to} #{zone_pfa.fin.s2h}".strip
  end

  def zone_relative_h de = nil, to = nil
    (exist? && debut) || return
    de ||= ''
    to ||= 'à'
    "#{de} #{zone_relative.debut.s2h} #{to} #{zone_relative.fin.s2h}".strip
  end

  # Le décalage avec la zone absolue, de façon
  # littéraire, i.e. "Trop tôt de 22 minutes",
  # "Trop tard de 1 heure 6 mns et 30 secs"
  def offset_litt
    @offset_litt ||= begin
      offset && begin
        'Trop ' + (offset > 0 ? 'tard' : 'tôt') +
        ' de ' + Film::Horloge.new(film, offset.abs.s2h).to_litt(:short)
      end
    end
  end

  # Le décalage avec la zone absolue, en horloge
  def offset_horloge
    offset && begin
      if offset >= 0
        offset.s2h
      else # offset < 0
        '- ' + (-offset).s2h
      end
    end
  end

end #/Point
end #/Structure
end #/Film
