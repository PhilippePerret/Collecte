# encoding: UTF-8
class Collecte
class Metadata

  def initialize collecte
    @collecte = collecte
    # @data contiendra toutes les données du fichier
    # metadata.collecte. On doit l'initialiser ici car
    # les méthodes de film et de collecte l'utilise
    # pour définir leurs valeurs.
    @data = Hash.new
  end

end #/Metadata
end #/Collecte
