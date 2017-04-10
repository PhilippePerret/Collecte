# encoding: UTF-8
class CFile

  # Le path au fichier, défini soit à l'instanciation
  # soit plus tard
  attr_accessor :path

  def exist?
    raise_if_path_undefined
    File.exist? path
  end
  def folder_exist?
    raise_if_path_undefined
    File.exist?(folder)
  end
  def affixe
    @affixe ||= begin
      raise_if_path_undefined
      File.basename(path, File.extname(path))
    end
  end
  def name ; @name ||= File.basename(path) end
  # On peut redéfinir le nom du fichier. Ceci redéfinit aussi
  # le path du fichier
  def name= value
    raise_if_path_undefined
    @name   = value
    @path   = File.join(folder, name)
    @affixe = nil # Pour son recalcul
  end

  def folder
    @folder ||= begin
      raise_if_path_undefined
      File.dirname(path)
    end
  end

end
