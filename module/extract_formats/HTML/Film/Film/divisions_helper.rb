# encoding: UTF-8
#
# Méthodes d'helper pour les divisions
#
class Fixnum

  # Transforme le nombre (qui doit être un nombre de secondes)
  # en valeur de pixel
  def to_pixels
    Collecte.current.film.timeline.secondes_to_pixels(0 + self)
  end
end #/Fixnum

class Film

  def div_exposition
    div('EXPOSITION', {style: "left:#{Timeline::TIMELINE_LEFT}px;width:#{real_quart.to_pixels}px", class:'tl-exposition acte'})
  end
  def div_developpement
    div('DÉVELOPPEMENT', {style:"left:#{left_developpement};width:#{moitie.to_pixels}px", class:'tl-developpement acte'})
  end
  def left_developpement
    "#{(Timeline::TIMELINE_LEFT + real_quart.to_pixels)}px"
  end
  def div_denouement
    div('DÉNOUEMENT', {style:"left:#{left_denouement};width:#{real_quart.to_pixels}px", class:'tl-denouement acte'})
  end
  def left_denouement
    "#{Timeline::TIMELINE_LEFT + real_trois_quarts.to_pixels + 2}px"
  end
  def div_pivot_1
    div("PVT1", {left:""})
  end
  def div_pivot_2

  end
  def div_cle_de_voute

  end
end#/Film
