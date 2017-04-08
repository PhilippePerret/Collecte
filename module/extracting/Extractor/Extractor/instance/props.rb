# encoding: UTF-8
class Collecte
class Extractor

  # {Collecte} L'instance de la collecte courante
  attr_reader :collecte

  # {Hash} Options d'extraction
  attr_accessor :options

  # {Symbol} Format de sortie des données
  def format ; @format ||= options[:format] end

  def film ; @film ||= collecte.film end

  def date
    @date ||= Time.now.strftime("%d %m %Y - %H:%M")
  end

end #/Extractor
end #/Collect
