# encoding: UTF-8
class Collecte
class Extractor

  def final_file
    @final_file ||= begin
      FinalFile.new(collecte)
    end
  end

  # Prépare le fichier en vue de l'extraction
  #
  # Construit le dossier `extraction` s'il n'existe pas
  #
  # Retourne true pour dire de continuer
  def prepare_file
    final_file.prepare
  end

end #/Extractor
end #/Collect
