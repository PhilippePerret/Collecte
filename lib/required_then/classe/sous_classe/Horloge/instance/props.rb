# encoding: UTF-8
class Film
class Horloge

  # {Film} Instance du film auquel appartient
  # l'horloge.
  attr_reader :film

  # {String} Horloge initiale
  attr_reader :horloge

  # {Fixnum} Durée éventuelle de l'horloge
  attr_accessor :duree

  def time
    @time ||= horloge.h2s
  end

  def end_time
    @end_time ||= begin
      duree.nil? ? nil : (time + duree)
    end
  end

end #/Horloge
end #/Film
