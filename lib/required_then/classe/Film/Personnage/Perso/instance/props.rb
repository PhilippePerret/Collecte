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

  # {String} "Homme" ou "Femme"
  attr_reader :sexe
  # {Fixnum} Année de naissance
  attr_reader :annee

  # {String} Prénom et nom de l'acteur
  attr_reader :prenom_acteur, :nom_acteur

  # {Hash} Tableau qui contient en clé l'IDs des personnages
  # avec lesquels ce personnage est en relation et en valeur
  # la liste des IDs de scène où ils sont en relation
  # Rappel : seules les relations sur plus de deux scènes
  # constitueront vraiment une relation, mais toutes sont
  # conservées ici.
  attr_accessor :relations

end #/Personnage
end #/Film
