# encoding: UTF-8
class Film
class Statistiques

  # Données PFA du film, mais seulement si la donnée structure
  # a été définie dans les métadonnées.
  # Cette méthode ajoute à la donnée film.structure les valeurs
  # absolues correspondant au paradigme de Field augmenté
  def data_pfa
    @data_pfa ||= begin
      if film.structure
        [
          [:dev_part1,  film.quart        ],
          [:denouement, film.trois_quarts ],
          [:dev_part2,  film.moitie       ],
          [:pivot1,     film.quart,         film.vingtquatrieme],
          [:pivot2,     film.trois_quarts,  film.vingtquatrieme],
          [:cdv,        film.moitie,        2*film.vingtquatrieme]
        ].each do |point, exact, tolerance|
          mitolerance = tolerance ? tolerance / 2 : 0
          film.structure[point][:pfa] = exact - mitolerance
          film.structure[point][:pfa_tolerance] = tolerance
        end
        film.structure.points
      else
        nil
      end
    end
  end
end #/Personnage
end #/Film
