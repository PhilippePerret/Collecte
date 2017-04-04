# encoding: UTF-8
class Film
class Scene

  # {Film} Instance du film auquel appartient la scène
  attr_reader :film

  # {Fixnum} Identifiant absolu de la scène
  # Attention, ça n'est pas nécessaire son numéro
  attr_reader :id

  # {Fixnum} Numéro de la scène
  attr_reader :numero

  # {String} Résumé de la scène
  attr_reader :resume

  # {Array de String} Liste des paragraphes
  attr_reader :paragraphes

  # {String} Fonction de la scène
  attr_reader :fonction

  def brins_ids
    @brins_ids
  end

  def personnages_ids
    @personnages_ids
  end
end #/Scene
end #/Film
