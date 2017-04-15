# encoding: UTF-8
class Film
class Structure
class Point

  # {Symbol} ID du point structure
  # p.e. :inc_dec ou :dev_part1
  attr_reader :id

  # {Any} Propriétaire
  attr_reader :owner

  def abs_data  ; @abs_data ||= ABS_POINTS_DATA[id] end

  # Raccourci
  def film ; @film ||= owner.film end

  # {String} Nom du point structurel
  def name          ; @name       ||= abs_data[:hname]          end
  def short_name    ; @short_name ||= abs_data[:short_hname]    end
  def coef_position ; @coef_posi  ||= abs_data[:paf]            end
  def tolerance     ; @tolerance  ||= abs_data[:tolerance] || 0 end

  # {Fixnum} Début et fin relatifs au film
  def start_relative  ; @start_relative || owner.horloge.real_time    end
  alias :debut :start_relative
  def end_relative    ; @end_relative   || owner.horloge.real_end_time end
  alias :fin :end_relative

  # {Film::Zone} La « zone absolue »
  def zone_pfa
    @zone_pfa ||= begin
      args = abs_data.merge(
        name:         "Zone #{abs_data[:de_l]} #{name}",
        duree_totale: film.duree
      )
      Film::Zone.new(args)
    end
  end


  # {Film::Zone} La zone relative du film, en fonction
  # de la scène (son début et sa fin)
  def zone_relative
    @zone_rel ||= begin
      if start_relative
        args = {debut: start_relative, fin: end_relative, position: start_relative}
        Film::Zone.new(args)
      else
        nil
      end
    end
  end

  # Retourne true si le point structurel est défini pour
  # le film courant
  def exist?
    zone_relative != nil
  end

  # Retourne true si le point structurel est défini et qu'il
  # se trouve dans la zone absolue.
  def in_zone?
    exist? && zone_relative.in_zone?(zone_pfa)
  end

  def out_zone?
    exist? && zone_relative.out_zone?(zone_pfa)
  end

  def offset
    @offset ||= begin
      exist? ? zone_relative.offset_with(zone_pfa) : nil
    end
  end

end #/Point
end #/Structure
end #/Film
