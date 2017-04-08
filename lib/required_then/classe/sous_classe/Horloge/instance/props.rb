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

  def real_time
    @real_time ||= time - film.start.time
  end

  def end_time
    @end_time ||= begin
      duree.nil? ? nil : (time + duree)
    end
  end
  def real_end_time
    @real_end_time ||= (end_time - film.start.time)
  end

  # Position left du temps sur une ligne de temps
  def left
    @left ||= Film::Timeline::TIMELINE_LEFT + film.timeline.secondes_to_pixels(time)
  end
  # Largeur de l'horloge en fonction de la durée de
  # l'objet
  def width
    @width ||= begin
      if duree
        film.timeline.secondes_to_pixels(duree)
      else
        4
      end
    end
  end

end #/Horloge
end #/Film
