# encoding: UTF-8
class Film
class Personnage

  # Les données qui seront enregistrées dans le fichier
  # marshal.
  def to_hash
    {
      id:                 id,
      line:               line,
      prenom:             prenom,
      nom:                nom,
      pseudo:             pseudo,
      sexe:               sexe,
      annee:              annee,
      fonction:           fonction,
      description:        description,
      nom_acteur:         nom_acteur,
      prenom_acteur:      prenom_acteur,
      scenes_ids:         scenes_ids,
      relations:          relations
    }
  end

  # Ajoute une scène au personnage (c'est donc une scène
  # où le personnage est présent)
  # +sc_id+ peut être un numéro (Fixnum) ou une instance
  # Film::Scene.
  #
  # N'ajoute la scène que si le personnage ne lui appartient
  # pas déjà (ça pourrait arriver).
  def add_scene sc_id
    sc_id.instance_of?(Fixnum) || sc_id = sc_id.numero
    @scenes_ids ||= Array.new
    @scenes_ids.include?(sc_id) || @scenes_ids << sc_id
  end
end #/Personnage
end #/Film
