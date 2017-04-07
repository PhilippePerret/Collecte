# encoding: UTF-8
class Collecte
class Extractor

  # {Collecte} L'instance de la collecte courante
  attr_reader :collecte

  # {Symbol} Format de sortie des données
  attr_accessor :format

  def film ; @film ||= collecte.film end

  def date
    @date ||= Time.now.strftime("%d %m %Y - %H:%M")
  end
  
end #/Extractor
end #/Collect
