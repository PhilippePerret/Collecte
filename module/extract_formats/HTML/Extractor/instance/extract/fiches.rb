# encoding: UTF-8
#
# Méthodes d'extraction des données propres au format
# HTML
#
class Collecte
class Extractor

  def extract_fiches_personnages
    film.personnages || return
    film.personnages.each do |perso_id, perso|
      write perso.as_fiche
    end
    final_file.flush
  end
  def extract_fiches_brins
    film.brins || return
    film.brins.each do |bid, brin|
      write brin.as_fiche
    end
    final_file.flush
  end
  def extract_fiches_notes
    film.notes || return
    film.notes.each do |nid, note|
      write note.as_fiche
    end
    final_file.flush
  end

end #/Extractor
end #/Collecte
