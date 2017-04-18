# encoding: UTF-8
class Film
class Decor

  # {Film} Le film auquel appartient le décor
  attr_reader :film

  # {Fixnum} Identifiant du décor
  attr_reader :id

  # {String} Parent du décor et sous-décor
  # {Fixnum} ID du décor parent
  attr_reader :parent_id
  # {String} Sous décor dans la décor parent.
  # Par exemple, si le décor est "MAISON DE JOE : JARDIN",
  # Le décor parent est "MAISON DE JOE" et le sous-décor est
  # "JARDIN"
  attr_reader :sous_decor

  # {String} Le décor
  attr_reader :decor

  # {String} Le lieu ('E' pour 'EXTÉRIEUR' ou 'I' pour 'INTÉRIEUR')
  attr_reader :lieu

  # {Array} Liste des IDs des scènes
  attr_reader :scenes_ids

end #/Decor
end #/Film
