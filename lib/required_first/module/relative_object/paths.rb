# encoding: UTF-8
=begin
  Classe principale d'un objet relatif
=end
module RelativeObjectMethods

  # Path du fichier contenant la liste des éléments collectés,
  # que ce soit des brins, des scenes ou des personnages
  def collecte_file
    @collecte_file ||= begin
      File.join(film.collecte.folder, collecte_file_name)
    end
  end

  def collecte_file_name
    "#{type_element}s.collecte"
  end

end #/ RelativeObject
