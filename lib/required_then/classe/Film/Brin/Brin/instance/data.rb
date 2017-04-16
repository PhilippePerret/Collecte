# encoding: UTF-8
class Film
class Brin

  # Les données qui seront enregistrées dans le fichier
  # marshal.
  def to_hash
    desc = description ? description.to_hash : nil
    {
      id:           id,
      line:         line,
      libelle:      libelle.to_hash,
      description:  desc,
      scenes_ids:   scenes_ids
    }
  end

end #/Brin
end #/Film
