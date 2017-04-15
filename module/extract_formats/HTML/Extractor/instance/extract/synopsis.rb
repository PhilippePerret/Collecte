# encoding: UTF-8
class Collecte
class Extractor

  # = main =
  #
  # Extraction de la collecte sous forme d'un synopsis
  #
  # Note
  # ----
  #   Si les points structurels sont définis, en tout cas
  #   les points du développement et du dénouement, on
  #   ajoute des espaces à ces endroits.
  def extract_synopsis
    # Le titre du document
    write div(final_file.titre_final, id: 'titre')
    # On ne prend que les scènes filtrées
    write '<section class="synopsis">'
    scenes.each do |scene|
      if scene.premiere_scene_acte?
        write '<div class="separation">***</div>'
      end
      write scene.as_synopsis
    end
    write '</section>' #/synopsis
    final_file.flush

    # Extraction des fiches personnages
    extract_fiches_personnages
  end

end #/Extractor
end #/Collecte
