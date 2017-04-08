# encoding: UTF-8
class Film
class Timeline

  # {Film} Film de la timeline
  attr_reader :film

  # {String} Le contenu de la timeline, c'est-à-dire les
  # blocs de scène.
  attr_reader :content

  def secondes_to_pixels secs
    (secs.to_f * coefficiant_pixels_per_secondes).to_i
  end

  def coefficiant_pixels_per_secondes
    @coefficiant_pixels_per_secondes || TIMELINE_WIDTH.to_f / film.duree
  end

end #/Timeline
end #/Film
