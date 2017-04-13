# encoding: UTF-8

class Film

  def marshal_file
    @marshal_file ||= File.join(collecte.data_folder, 'film.msh')
  end

  def pstore_file
    @pstore_file ||= File.join(collecte.data_folder, 'film.pstore')
  end

end #/Film
