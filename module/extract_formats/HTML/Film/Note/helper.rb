# encoding: UTF-8
class Film
class Note

  def as_link
    link("note #{id}", {href: '#', onclick:"return ShowNote(#{id})"})
  end

  # Retourne le code HTML de la note comme fiche
  def as_fiche
    div(
      closebox("return HideCurFiche()") +
      div("Note #{id}", class: 'titre') +
      libval('Description', content_displayed, class: 'description'),
      {class: 'fiche note hidden', id: "fiche-note-#{id}"}
    )
  end

  def content_displayed
    # Note : content est un Film::TextObjet
    content.to_html
  end

end #/Note
end #/Film
