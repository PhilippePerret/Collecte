# encoding: UTF-8
class Collecte
class Extractor

  # = main =
  #
  # Extraction de la collecte sous forme d'un synopsis
  def extract_synopsis
    # Le titre du document
    write div(final_file.titre_final, id: 'titre')
    # On ne prend que les scènes filtrées
    write '<section class="synopsis">'
    scenes.each do |scene|
      write scene.as_synopsis
    end
    write '</section>' #/synopsis
    final_file.flush

    # Extraction des fiches personnages
    extract_fiches_personnages
  end

end #/Extractor
end #/Collecte
