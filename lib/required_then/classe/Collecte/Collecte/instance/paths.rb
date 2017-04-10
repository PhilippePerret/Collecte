# encoding: UTF-8
class Collecte

  # Ce n'est pas un path, c'est un HTMLFile qui permet
  # d'afficher le journal de bord de la collecte, lorsque
  # l'option `debug: true` a été spécifiée
  def log_file
    @log_file ||= HTMLFile.new(self, File.join(folder,'log.html'))
  end

  # L'instance {Film} du film de la collecte
  def folder
    @folder
  end

  # Le dossier qui va contenir les données de la collecte, à
  # commencer par les fichier marshal obtenus lors du parsing
  def data_folder
    @data_folder ||= File.join(folder, 'data')
  end
end
