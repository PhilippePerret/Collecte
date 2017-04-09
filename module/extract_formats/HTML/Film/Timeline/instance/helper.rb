# encoding: UTF-8
class Film
class Timeline

  def as_div
    div(content, {class: 'timeline', style:"width:#{TIMELINE_WIDTH}px;left:#{TIMELINE_LEFT}px;"})
  end
  def content
    film.div_exposition +
    film.div_developpement +
    film.div_denouement
  end

end #/Timeline
end #/Film
