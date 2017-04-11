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

  # Raccourcis
  def options ; @options  ||= collecte.extractor.options  end
  def film    ; @film     ||= collecte.film               end

  # Le titre final, en fonction du type
  attr_accessor :titre_final
  # La balise TITLE pour le format HTML
  attr_accessor :title
  # Liste des fichiers javascript à charger (en dur),
  # défini par `set_by_type`
  attr_accessor :javascript_files
  # Liste des fichiers CSS à charger (en dur), défini
  # par `set_by_type`
  attr_accessor :css_files


end #/FinalFile
end #/Extractor
end #/Collecte
