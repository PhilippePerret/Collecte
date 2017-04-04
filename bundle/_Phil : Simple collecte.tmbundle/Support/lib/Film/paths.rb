# encoding: UTF-8

class Film
class << self
  # Le fichier courant (relève, brins, personnages, etc)
  def current_file
    @current_file ||= ENV['TM_FILEPATH']
  end
  # Le dossier courant du film courant collecté
  def folder
    @folder ||= File.dirname(current_file)
  end
  def affixe
    @affixe ||= File.basename(current_file, File.extname(current_file))
  end
end
end