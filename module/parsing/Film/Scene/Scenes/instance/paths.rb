# encoding: UTF-8
class Film
class Scenes

  # Path du fichier contenant la liste des brins colllectés
  def collecte_file
    @collecte_file ||= File.join(film.collecte.folder, 'scenes.simple_collecte')
  end

end #/Scenes
end #/Film
