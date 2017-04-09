# encoding: UTF-8
class Film
class TextObjet

  def to_html
    c = only_str.dup

    # Traitement des personnages de l'objet
    c = Film::Personnage.traite_balises_in(c)

    objets_relatifs = Array.new

    # Traitement des notes du texte-objet
    (notes_ids||[]).each do |nid|
        note = film.notes[nid]
        note != nil || raise("Impossible de trouver la note ##{nid}…")
        objets_relatifs << note.as_link
      end

    # Traitement des brins du texte-objet
    (brins_ids||[]).each do |bid|
      brin = film.brins[bid]
      brin != nil || raise("Impossible de trouve le brin ##{bid}…")
      objets_relatifs << brin.as_link
    end

    if objets_relatifs.count > 0
      c << '<sup>'+objets_relatifs.join(', ')+'</sup>'
    end
    return c
  end

end #/TextObjet
end #/Film
