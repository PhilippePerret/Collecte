# encoding: UTF-8
class Film
class Brin

  def as_link
    link("brin #{id}", {href: '#', onclick:"return ShowBrin(#{id})"})
  end

  # Retourne le code HTML pour la fiche du brin
  def as_fiche
    div(
      closebox("return HideCurFiche()") +
      showinTM_link +
      div(libelle.to_html, class: 'titre') +
      to_html,
      {class: 'fiche brin hidden', id: "fiche-brin-#{id}"}
    )
  end
  def to_html
    c = String.new
    c << libval('Brin', id)
    description && c << libval('Description', description.to_html, class: 'description')
    return c
  end

  # Code HTML de la ligne de temps du brin
  def timeline
    div('', {class: 'timeline', style: "left:#{Film::Timeline::TIMELINE_LEFT}px;width:#{Film::Timeline::TIMELINE_WIDTH}px"} )
  end

end #/Brin
end #/Film
