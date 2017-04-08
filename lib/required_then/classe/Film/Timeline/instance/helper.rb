# encoding: UTF-8
class Film
class Timeline

  def as_div
    div('', {class: 'timeline', style:"width:#{TIMELINE_WIDTH}px;left:#{TIMELINE_LEFT}px;"})
  end

end #/Timeline
end #/Film
