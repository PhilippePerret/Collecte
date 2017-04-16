# encoding: UTF-8
class Film
class Decor

  # {Film} Le film auquel appartient le décor
  attr_reader :film

  # {Fixnum} Identifiant du décor
  attr_reader :id

  # {String} Parent du décor et sous-décor
  # Par exemple, si le décor est "MAISON DE JOE : JARDIN",
  # Le décor parent est "MAISON DE JOE" et le sous-décor est
  # "JARDIN"
  attr_reader :decor_parent, :sous_decor

  # {String} Le décor
  attr_reader :decor

  # {String} Le lieu (EXT. ou INT.)
  attr_reader :lieu

end #/Decor
end #/Film
