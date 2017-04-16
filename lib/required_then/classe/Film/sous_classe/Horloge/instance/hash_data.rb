# encoding: UTF-8
class Film
class Horloge

  # Pour l'enregistrement de l'horloge
  def to_hash
    {
      horloge:        horloge,
      time:           time,
      real_time:      real_time,
      end_time:       end_time,
      real_end_time:  real_end_time,
      duree:          duree
    }
  end

end #/Horloge
end #/Film
