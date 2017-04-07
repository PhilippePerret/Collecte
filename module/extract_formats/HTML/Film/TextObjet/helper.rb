# encoding: UTF-8
class Film
class TextObjet

  def to_html
    c = only_str.dup

    # Traitement des personnages de la scène
    c.gsub!(/\[PERSO\#(.*?)\]/){
      pid = $1
      perso = film.personnages[pid]
      perso != nil || raise("Impossible d'obtenir le personnage ##{pid}. Il faut le définir impérativement.")
      perso.as_link
    }

    # Traitement des notes de la scènes
    c << (notes_ids||[]).collect do |nid|
        note = film.notes[nid]
        note != nil || raise("Impossible de trouver la note ##{nid}…")
        note.as_link
      end.join(' ')

    return c
  end

end #/TextObjet
end #/Film
