# encoding: UTF-8
class Collecte

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
