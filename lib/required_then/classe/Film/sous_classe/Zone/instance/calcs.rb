# encoding: UTF-8
#
# Classe Film::Zone
#
# Pour une zone de temps
class Film
class Zone

  # Calcul de tous les temps en fonction des valeurs
  # transmises et des valeurs absolues
  def calcule_temps
    if coefpos
      @position = (coefpos * duree_totale).to_i
      duree_tolerance = duree_totale.to_f * tolerance
      demi_tolerance = (duree_tolerance / 2).to_i
      @debut    = position - demi_tolerance
      @fin      = debut + duree_tolerance.to_i
    else
      if coef_before
        @debut  = 0 # si coef_debut n'est pas défini
        @fin    = (coef_before * duree_totale).to_i
      end
      if coef_after
        @debut = (coef_after * duree_totale).to_i
        @fin ||= duree_totale
      end
    end
    if fin && debut
      @duree    = fin - debut
      # Si @position n'a pas été définie (ce qui arrive lorsque
      # coefpos n'est pas défini mais coef_after ou coef_before
      # oui)
      @position ||= debut + (@duree / 2)
    end
    @temps_are_defined = true
  end

  # Retourne true si la zone courante se trouve dans la
  # zone +z+ fournie.
  # se trouve dans la zone.
  def in_zone? z
    (debut && z.debut) || (return nil)
    fin > z.debut && debut < z.fin
  end

  # Retourne true si la zone courante se trouve en dehors
  # de la zone +z+ fournie
  def out_zone? z
    (debut && z.debut) || (return nil)
    fin < z.debut || debut > z.fin
  end

  # Retourne le décalage de la zone courante avec la
  # zone +z+ fourni.
  # Si la zone courante est « in zone », zéro est retourné
  # Si la zone courante est avant z, un nombre négatif est
  # retourné.
  # Si la zone courante est après z, un nombre positif est
  # retourné
  def offset_with z
    (debut && z.debut) || (return nil)
    out_zone?(z)  || (return 0)
    if fin < z.debut
      fin - z.debut # => négatif
    else # debut > z.fin
      debut - z.fin # => positif
    end
  end

end #/Zone
end #/Film
