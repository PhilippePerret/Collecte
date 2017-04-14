# encoding: UTF-8
class Film
class Statistiques

  # Instance Film du film dont les statistiques sont
  # demandées
  attr_reader :film

  def collecte ; @collecte  ||= film.collecte end
  def extractor ;@extractor ||= collecte.extractor end

  # Les éléments du film, MAIS SEULEMENT ceux qui apparaissent
  # avec le filtre donné.
  def scenes      ; @scenes       ||= extractor.scenes      end
  def personnages ; @personnages  ||= extractor.personnages end
  def brins       ; @brins        ||= extractor.brins       end
  
end #/Statistiques
end #/Film
