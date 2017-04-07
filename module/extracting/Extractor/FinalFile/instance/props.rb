# encoding: UTF-8
class Collecte
class Extractor
class FinalFile

  # {Collecte} Instance de la collecte du fichier
  attr_reader :collecte

  # {String} Contenu à flusher dans le fichier
  # Noter qu'il ne contient jamais tout le code, mais
  # seulement une partie courante (par exemple seulement
  # les brins s'ils sont en train d'être traités)
  attr_reader :file_content

  def format ; @format ||= options[:format] end

  # {Symbol} Type du fichier 
  def type ; @type ||= options[:type] end

end #/FinalFile
end #/Extractor
end #/Collecte
