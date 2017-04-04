# encoding: UTF-8

module ListElementsMethods

  # Retourne true si le fichier de collecte de l'élément
  # existe, pour les brins, les personnages ou les scènes
  def collecte_exist?
    File.exist? collecte_file
  end

end
