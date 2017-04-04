# encoding: UTF-8
class Film
class Personnage

  # {Film} Instance du film auquel appartient le personnage
  attr_reader :film

  # {String} Identifiant absolu du personnage
  attr_reader :id

  # {String} Prénom, nom et pseudo du personnage
  attr_reader :prenom, :nom
  def pseudo ; @pseudo ||= "#{prenom} #{nom}".strip end

  # {String} Fonction du personnage
  attr_reader :fonction

  # {String} Description du brin
  attr_reader :description

  # {String} Prénom et nom de l'acteur
  attr_reader :prenom_acteur, :nom_acteur

end #/Personnage
end #/Film
