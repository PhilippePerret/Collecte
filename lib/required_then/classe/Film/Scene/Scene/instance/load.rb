# encoding: UTF-8
class Film
class Scene

  alias :top_dispatch :dispatch
  def dispatch hdata
    top_dispatch hdata
    @resume       = Film::TextObjet.new(film).dispatch(@resume)
    @horloge      = Film::Horloge.new(film, horloge)
    @paragraphes  = paragraphes.collect do |hparagraphe|
      Film::TextObjet.new(film).dispatch(hparagraphe)
    end
  end

end #/Scene
end #/Film
