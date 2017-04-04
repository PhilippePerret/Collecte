# encoding: UTF-8
class Film
class Personnage

  # ------------------------------------------------------
  # Voir les propriétés héritées des RelativeObjectMethods
  # ------------------------------------------------------

  # {String} Prénom, nom et pseudo du personnage
  attr_reader :prenom, :nom
  def pseudo ; @pseudo ||= "#{prenom} #{nom}".strip end

  # {String} Fonction du personnage
  attr_reader :fonction

  # {String} Prénom et nom de l'acteur
  attr_reader :prenom_acteur, :nom_acteur

end #/Personnage
end #/Film
