# encoding: UTF-8
class Film
class Scene

  # ------------------------------------------------------
  # Voir les propriétés héritées des RelativeObjectMethods
  # ------------------------------------------------------

  # {Fixnum} Numéro de la scène
  attr_reader :numero

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

end #/Scene
end #/Film
