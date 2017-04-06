# encoding: UTF-8
class Collecte

  # Méthode principale appelée pour extraire les
  # données collectées
  def extract options = nil
    extractor(options.delete(:format)).extract_data(options)
  end

  # Module d'extraction des données
  def extractor frmt = nil
    @extractor ||= begin
      Collecte.load_module('extracting')
      inst = Extractor.new(self)
      inst.format= (frmt || :html)
      inst
    end
  end


end
