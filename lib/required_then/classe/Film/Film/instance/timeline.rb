# encoding: UTF-8
class Film

  def timeline
    @timeline ||= Timeline.new(self)
  end

end #/Film
