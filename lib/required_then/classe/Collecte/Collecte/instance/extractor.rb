# encoding: UTF-8
class Collecte

  # Méthode principale appelée pour extraire les
  # données collectées
  def extract options = nil
    extractor.extract_data(options)
  end

  # Module d'extraction des données
  def extractor
    @extractor ||= Extractor.new(self)
  end


end
