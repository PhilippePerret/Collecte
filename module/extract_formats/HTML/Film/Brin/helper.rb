# encoding: UTF-8
class Film
class Brin

  def as_link
    link("brin #{id}", {href: '#', onclick:"return ShowBrin(#{id})"})
  end

  # Retourne le code HTML pour la fiche du brin
  def as_fiche
    div(
      closebox("return HideBrin(#{id})") +
      div(libelle, class: 'titre') +
      div(description, class: 'description'),
      {class: 'fiche brin hidden', id: "fiche-brin-#{id}"}
    )
  end

  # Code HTML de la ligne de temps du brin
  def timeline
    div('', {class: 'timeline', style: "left:#{Film::Timeline::TIMELINE_LEFT}px;width:#{Film::Timeline::TIMELINE_WIDTH}px"} )
  end

end #/Brin
end #/Film
