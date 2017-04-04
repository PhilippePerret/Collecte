# encoding: UTF-8
class Film
class Note

  # Les données qui seront enregistrées dans le fichier
  # marshal.
  def hash_data
    {
      id:             id,
      scene_id:       scene_id,
      content:        content.hash_data
    }
  end

end #/Note
end #/Film
