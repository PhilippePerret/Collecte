# encoding: UTF-8
#
# Méthodes permettant d'extraire les données collectées
#
class Collecte
class Extractor


  def extension
    case format
    when :html  then 'html'
    when :text  then 'txt'
    when :xml   then 'xml'
    end
  end
  
  def path
    @path ||= File.join(folder, "extract_data.#{extension}")
  end

  # Dossier contenant les fichiers extraits
  def folder
    @folder ||= File.join(collecte.folder, 'extraction')
  end
end #/Extractor
end #/Collect
