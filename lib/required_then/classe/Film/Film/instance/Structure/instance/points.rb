# encoding: UTF-8
class Film
class Structure

  # Pour obtenir un « point », par exemple
  # film.structure[:developpement]
  def [] point_name
    point_name =
      case point_name
      when :developpement         then :dev_part1
      when :incident_perturbateur then :inc_pert
      when :incident_declencheur  then :inc_dec
      else point_name
      end
    points[point_name]
  end

  # Hash de tous les points structurels
  # Instances de Film::Structure::Point
  def points
    @points ||= begin
      h = Hash.new
      Point::ABS_POINTS_DATA.each do |pt_name|
        h.merge!(pt_name => Point.new(film, pt_name))
      end
      h
    end
  end

end #/Structure
end #/Film
