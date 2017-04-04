# encoding: UTF-8
class Film
class Personnage

  # Les données qui seront enregistrées dans le fichier
  # marshal.
  def hash_data
    {
      id:             id,
      prenom:         prenom,
      nom:            nom,
      pseudo:         pseudo,
      fonction:       fonction,
      description:    description,
      nom_acteur:     nom_acteur,
      prenom_acteur:  prenom_acteur,
      scenes_ids:     scenes_ids
    }
  end

end #/Personnage
end #/Film
