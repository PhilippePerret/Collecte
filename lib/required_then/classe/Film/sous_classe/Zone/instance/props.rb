# encoding: UTF-8
#
# Classe Film::Zone
#
# Pour une zone de temps
class Film
class Zone

  # {String} Nom complet de la zone
  # P.e. « Zone du Climax »
  attr_reader :name
  # {Float} Coefficient de position
  attr_reader :coefpos
  # {Float} Coefficient de position avant
  # Si défini, un point est in zone s'il commence avant
  # le temps correspondant à ce coefficient.
  attr_reader :coef_before
  # {Float} Coefficient de position après
  # Si défini, un point est in zone s'il commence après
  # le temps correspondant à ce coefficient.
  attr_reader :coef_after
  # {Fixnum} Durée totale du film
  attr_reader :duree_totale
  # {Fixnum secondes} Tolérance
  def tolerance ; @tolerance || 0 end

  # Cf. README.md
  attr_reader :position, :debut, :fin, :duree


end #/Zone
end #/Film
