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
  attr_accessor :format

  def film ; @film ||= collecte.film end

end #/Extractor
end #/Collect
