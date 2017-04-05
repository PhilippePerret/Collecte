# encoding: UTF-8
class Film
class Brins

  # Path du fichier contenant la liste des brins colllectés
  def collecte_file
    @collecte_file ||= File.join(film.collecte.folder, 'brins.collecte')
  end

end #/Brins
end #/Film
