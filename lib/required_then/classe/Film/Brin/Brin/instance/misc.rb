# encoding: UTF-8
class Film
class Brin

  # Les données qui seront enregistrées dans le fichier
  # marshal.
  def hash_data
    desc = description ? description.hash_data : nil
    {
      id:           id,
      line:         line,
      libelle:      libelle.hash_data,
      description:  desc,
      scenes_ids:   scenes_ids
    }
  end

end #/Brin
end #/Film
