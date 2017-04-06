# encoding: UTF-8
class Collecte
class Extractor

  # {Collecte} L'instance de la collecte courante
  attr_reader :collecte

  # {String} Contenu du fichier
  # C'est le texte qui sera extrait, contenant toutes les
  # données extraites.
  attr_reader :file_content
  
  # {Symbol} Format de sortie des données
  attr_reader :format

end #/Extractor
end #/Collect
