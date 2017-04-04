# encoding: UTF-8
class Film
class Scenes

  # Path du fichier contenant les données marshalisées
  def marshal_file
    @marshal_file ||= File.join(film.collecte.data_folder, 'scenes.msh')
  end

end #/Scenes
end #/Film
