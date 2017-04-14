# encoding: UTF-8
class Film
class Horloge

  # {Film} Instance du film auquel appartient
  # l'horloge.
  attr_reader :film

  # {String} Horloge initiale
  attr_reader :horloge

  # {Fixnum} Durée éventuelle de l'horloge
  # Défini après le parse complet du fichier
  # des scènes
  attr_accessor :duree

  def time
    @time ||= horloge.h2s
  end

  # Le temps réel, en considérant que la première scène
  # n'est jamais à 0:00:00
  def real_time
    @real_time ||= time - film.start.time
  end

  # L'horloge réelle, découlant du temps réel
  def real_horloge
    @real_horloge ||= real_time.s2h
  end

  def end_time
    @end_time ||= begin
      duree.nil? ? nil : (time + duree)
    end
  end
  def real_end_time
    @real_end_time ||= begin
      end_time ? (end_time - film.start.time) : nil
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
