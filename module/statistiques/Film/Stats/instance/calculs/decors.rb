# encoding: UTF-8
class Film
class Statistiques


  # Pour analyser les décors
  def analyze_decors
    @main_decors    = Hash.new
    film.decors.each do |did, decor|
      if false == @main_decors.key?(decor.decor)
        @main_decors.merge!(decor.decor => {
          id:           decor.id,
          decor:        decor.decor,
          lieu:         decor.lieu,
          sous_decors:  Array.new,
          duree:        0
          })
      end

      # On mémorise le sous-décor, même s'il est nil. Noter que
      # ce sous-décor est forcément unique.
      @main_decors[decor.decor][:sous_decors] << decor

      # On calcule la durée d'utilisation de ce décor et
      # de ce sous-décor
      @main_decors[decor.decor][:duree] += decor.duree
    end
    @nombre_decors_principaux = @main_decors.count
  end

  # Les décors parents, ceux qui contiennent ensuite
  # des sous-décors
  def main_decors
    @main_decors || analyze_decors
    @main_decors
  end

  # Nombre de décors
  # Le calcul du nombre de décors est un peu plus compliqué
  # que le calcul du nombre des autres éléments, à cause de
  # leur façon d'être enregistrés. Notamment parce qu'il faut
  # considérer les décors et les sous-décors.
  # Par exemple, on peut avoir :
  #   MAISON DE JOE
  #   MAISON DE JOE : SALON
  #   MAISON DE JOE : CHAMBRE
  # Ce sont tous des `decors` différents au sens du programme,
  # mais pour les statistiques, il faut compte qu'il y a un
  # seul décor principal/parent et des sous-décors.
  def nombre_total_decors
    @nombre_total_decors || analyze_decors
    @nombre_total_decors ||= film.decors.count
  end
  def nombre_decors_principaux
    @nombre_decors_principaux || analyze_decors
    @nombre_decors_principaux
  end

  # Retourne les décors par temps d'utilisation, en faisant
  # la distinction entre les décors principaux, et les sous-décors
  # Ça doit permettre un résultat sous la forme :
  #   DÉCOR PRINCIPAL.........  <durée totale>
  #       SEUL (if any).........<durée>
  #       SOUS-DÉCOR 1..........<durée>
  #       SOUS-DÉCOR 2..........<durée>
  #   DÉCOR PRINCIPAL
  #   etc.
  #
  # La donnée retournée est une liste de Hash qui contiennent
  #   :main_decor     Le décor principal, nil si c'est un sous-decor
  #   :sous_decor     Le sous-décor, nil si c'est un décor principal
  #   :duree          La durée d'utilisation
  def decors_par_temps_utilisation
    @nombre_decors_principaux || analyze_decors
    arr = Array.new
    @main_decors
    .sort_by{|mdecor, hdecor| - hdecor[:duree]}
    .each do |mdecor, hdecor|
      hdecor[:sous_decors]
      .sort_by{|sdecor| (sdecor.sous_decor||'')}
      .each do |sdecor|
        is_main = sdecor.sous_decor.nil?
        plusieurs_sdecors = hdecor[:sous_decors].count > 1

        if is_main
          arr << {
            data1: (plusieurs_sdecors ? '' : sdecor.id),
            data2: (plusieurs_sdecors ? 'Durée totale : ':'') + "#{hdecor[:duree].s2h}",
            data3: "<strong>#{sdecor.decor}</strong>"
          }
          # Utilisation du décor principal seul, mais seulement
          # s'il a des sous-décors
          if plusieurs_sdecors
            arr << {
              data1: sdecor.id,
              data3: '(décor seul)', data2: sdecor.duree.s2h
            }
          end
        else
          arr << {
            # data1: nil, # main décor
            data1: sdecor.id,
            data2: sdecor.duree.s2h, # durée
            data3: "<decor>#{sdecor.decor} : #{sdecor.sous_decor}</decor>" # sous-décor
          }
        end
      end
    end
    return arr
  end

end #/Statistiques
end #/Film