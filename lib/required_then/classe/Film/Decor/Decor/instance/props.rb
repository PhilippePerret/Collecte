# encoding: UTF-8
class Film
class Decor

  # {Film} Le film auquel appartient le décor
  attr_reader :film

  # {Fixnum} Identifiant du décor
  attr_reader :id

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

  # Durée d'utilisation du décor courant
  # Noter qu'il s'agit du décor + sous-décor
  def duree
    @duree ||= begin
      s = 0 ; scenes.each{|sid, scene| s += scene.duree } ; s
    end
  end

end #/Decor
end #/Film
