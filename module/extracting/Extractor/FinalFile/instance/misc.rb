# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  # Préparation du fichier
  def prepare
    File.exist?(folder) || Dir.mkdir(folder, 0755)
    @file_content = String.new
    File.exist?(path) && File.unlink(path)
    File.open(path,'wb'){|f| f.write code_depart}
    return true # pour dire de continuer
  end

end #/FinalFile
end #/Extractor
end #/Collecte
