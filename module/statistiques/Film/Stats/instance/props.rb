# encoding: UTF-8
class Film
class Statistiques

  # Instance Film du film dont les statistiques sont
  # demandées
  attr_reader :film

  def collecte ; @collecte  ||= film.collecte end
  def extractor ;@extractor ||= collecte.extractor end

  # Les scènes dont il faut tenir compte pour les
  # statistiques
  def scenes ; @scenes ||= extractor.scenes end

  # Les personnages, mais seulement ceux qui apparaissent
  # dans le temps donné (TODO)
  def personnages
    @personnages ||= film.personnages
  end
end #/Statistiques
end #/Film
