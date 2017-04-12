# encoding: UTF-8
class Collecte
class Extractor

  # = main =
  #
  # Extraction de la collecte sous forme d'un synopsis
  def extract_resume
    # Le titre du document
    write div(final_file.titre_final, id: 'titre')
    # On ne prend que les scènes filtrées
    write '<section class="resumes">'
    scenes.each do |scene|
      write span(scene.resume.only_str, {class: 'resume'})
    end
    write '</section>' #/synopsis
    final_file.flush
  end

end #/Extractor
end #/Collecte
