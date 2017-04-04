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

  # {Film::Horloge} Horloge de la scène
  attr_reader :horloge

  # {String} Effet
  attr_reader :effet, :effet_alt

  # {String} Lieu
  attr_reader :lieu, :lieu_alt

  # {String} Décor
  attr_reader :decor, :decor_alt

  # {Film::TextObjet} Résumé de la scène
  attr_reader :resume

  # {Array de Film::TextObjet} Liste des paragraphes
  attr_reader :paragraphes

  # {Array de Film::Note}
  attr_reader :notes

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
