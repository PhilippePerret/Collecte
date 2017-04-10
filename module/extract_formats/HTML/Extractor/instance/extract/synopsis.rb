# encoding: UTF-8
class Collecte
class Extractor

  # = main =
  #
  # Extraction de la collecte sous forme d'un synopsis
  def extract_synopsis
    # On ne prend que les scènes filtrées
    write '<section class="synopsis">'
    scenes.each do |scene|
      write scene.as_synopsis
    end
    write '</section>' #/synopsis
    final_file.flush
  end

end #/Extractor
end #/Collecte
