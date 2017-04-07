# encoding: UTF-8
class Film
class Note

  def as_link
    link("note #{id}", {href: '#', onclick:"return ShowNote(#{id})"})
  end

  # Retourne le code HTML de la note comme fiche
  def as_fiche
    div(
      closebox("return HideNote(#{id})") +
      div("Note #{id}", class: 'titre') +
      div(content.to_html, class: 'description'),
      {class: 'fiche note hidden', id: "fiche-note-#{id}"}
    )
  end
end #/Note
end #/Film
