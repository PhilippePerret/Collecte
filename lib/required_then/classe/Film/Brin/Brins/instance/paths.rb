# encoding: UTF-8
class Film
class Brins

  # Path du fichier contenant les données marshalisées
  def marshal_file
    @marshal_file ||= File.join(film.collecte.data_folder, 'brins.msh')
  end

end #/Brins
end #/Film
