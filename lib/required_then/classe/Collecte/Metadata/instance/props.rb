# encoding: UTF-8
class Collecte
class Metadata

  # {Collecte} Instance de la collecte
  attr_reader :collecte

  # {Hash} de toutes les données collectées. Ce sont
  # des propriétés en minuscules symboliques.
  # {:id, :titre, :auteurs_collecte, etc.}
  attr_accessor :data

  # Raccourci
  def film; @film ||= collecte.film end

end #/Metadata
end #/Collecte
