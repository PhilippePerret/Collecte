# encoding: UTF-8
class Film
class Personnages

  # Path du fichier contenant les données marshalisées
  def marshal_file
    @marshal_file ||= File.join(film.collecte.data_folder, 'personnages.msh')
  end

end #/Personnages
end #/Film
