# encoding: UTF-8
class Film
class Scene

  # Les données qui seront enregistrées dans le fichier
  # marshal.
  def hash_data
    {
      id:               id,
      numero:           numero,
      time:             time,
      resume:           resume,
      fonction:         fonction,
      brins_ids:        brins_ids,
      personnages_ids:  personnages_ids
    }
  end

end #/Scene
end #/Film
