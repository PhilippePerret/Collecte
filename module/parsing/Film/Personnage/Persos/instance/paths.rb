# encoding: UTF-8
class Film
class Personnages

  # Path du fichier contenant la liste des brins colllectés
  def collecte_file
    @collecte_file ||= File.join(film.collecte.folder, 'personnages.collecte')
  end

end #/Personnages
end #/Film
