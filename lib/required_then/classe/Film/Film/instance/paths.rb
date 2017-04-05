# encoding: UTF-8

class Film
  
  def marshal_file
    @marshal_file ||= File.join(collecte.data_folder, 'film.msh')
  end

end #/Film
