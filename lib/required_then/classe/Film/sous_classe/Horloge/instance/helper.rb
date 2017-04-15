# encoding: UTF-8
class Film
class Horloge

  # Pour exprimer le laps de temps de façon littéraire,
  # i.e. "1 heure, "
  def to_litt fmt = nil
    fmt ||= :short
    uh, um, us = fmt == :short ? ['heure', 'mn', 'sec'] : ['heure', 'minute', 'seconde']
    uh += heures > 1 ? 's' : ''
    um += minutes > 1 ? 's' : ''
    us += secondes > 1 ? 's' : ''
    str = Array.new
    heures > 0 && str << "#{heures} #{uh}"
    minutes > 0 && str << "#{minutes} #{um}"
    secondes > 0 && str << "#{secondes} #{us}"
    # Le retour string
    if str.count > 1
      dernier = str.pop
      "#{str.join(' ')} et #{dernier}"
    else
      str.first
    end
  end

  # Position left du temps sur une ligne de temps
  def left
    @left ||= Film::Timeline::TIMELINE_LEFT + film.timeline.secondes_to_pixels(real_time)
  end
  # Largeur de l'horloge en fonction de la durée de
  # l'objet
  def width
    @width ||= begin
      if duree
        film.timeline.secondes_to_pixels(duree, 2) + 1
      else
        4
      end
    end
  end

end #/Horloge
end #/Film
