# encoding: UTF-8
class Film
class Structure
class Point

  # {Symbol} ID du point structure
  # p.e. :inc_dec ou :dev_part1
  attr_reader :id

  # {Hash} Données qui peuvent être envoyées à l'instanciation
  attr_reader :data

  # {String} Nom du point structurel
  def name  ; @name ||= ABS_POINTS_DATA[id][:hname] end
  # La position pfa, en float, par exemple 0.5 pour la clé de voûte
  def pfa_abs
    @pfa  ||= begin
      ABS_POINTS_DATA[id][:pfa] * film.duree
    end
  end
  def short_name  ; @short_name ||= ABS_POINTS_DATA[id][:short_hname] end

end #/Point
end #/Structure
end #/Film
