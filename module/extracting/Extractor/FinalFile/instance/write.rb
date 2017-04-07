# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  def << code
    @file_content << code
  end

  # Vider le contenu provisoire dans le fichier
  def flush
    File.open(path,'a'){|f| f.write @file_content}
    @file_content = ''
  end

end #/FinalFile
end #/Extractor
end #/Collecte
