# encoding: UTF-8
class Film
class Personnage

  def as_link
    link(pseudo, {href: '#', onclick:"return ShowPersonnage('#{id}')"})
  end

  # Retourne le code HTML pour la fiche du personnage
  def as_fiche
    div(
      closebox("return HidePersonnage('#{id}')") +
      div(pseudo, class: 'titre') +
      div(self.to_html, class: 'description'),
      {class: 'fiche personnage hidden', id: "fiche-personnage-#{id}"}
    )
  end

  def to_html
    c = String.new
    fonction    && c << libval('Fonction', fonction)
    annee       && c << libval('Année de naissance', annee)
    description && c << div(description)
    return c
  end
  def libval label, value
    div(
      span(label, class: 'label')+
      span(value, class: 'value')
    )
  end

end #/Personnage
end #/Film
