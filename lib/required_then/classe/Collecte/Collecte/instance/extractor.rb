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

      # Avant tout, si une extraction doit être faite,
      # il faut charger les données du film ou le parser
      if File.exist?(film.marshal_file)
        film.load
      else
        parse
      end

      # On peut ensuite faire l'extracteur
      Collecte.load_module('extracting')
      inst = Extractor.new(self)
      inst.options = {format: (frmt||:html)}
      inst
    end
  end


end
