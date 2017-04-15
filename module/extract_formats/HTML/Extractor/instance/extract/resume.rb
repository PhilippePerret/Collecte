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
      write '<p></p>' if scene.premiere_scene_acte?
      write span(scene.resume.to_html(no_relatifs: true), {class: 'resume'})
    end
    write '</section>' #/synopsis
    final_file.flush
  end

end #/Extractor
end #/Collecte
