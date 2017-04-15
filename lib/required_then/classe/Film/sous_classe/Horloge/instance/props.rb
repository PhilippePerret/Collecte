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

  # Le nombre d'heures du début
  def heures
    @heures ||= splitted_time[0].to_i
  end
  # Le nombre de minutes du début
  def minutes
    @minutes ||= splitted_time[1].to_i
  end
  # Le nombre de secondes du début
  def secondes
    @secondes ||= splitted_time[2].to_i
  end

  def heures_end
    @heures_end ||= splitted_end_time[0].to_i
  end
  def minutes_end
    @minutes_end ||= splitted_end_time[1].to_i
  end
  def secondes_end
    @secondes_end ||= splitted_end_time[2].to_i
  end

  def splitted_time
    @splitted ||= time.s2h.split(':')
  end
  def splitted_end_time
    @splitted_end_time ||= end_time.s2h.split(':')
  end

end #/Horloge
end #/Film
