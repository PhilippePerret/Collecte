# encoding: UTF-8
class Film
class Personnage

  def as_link
    link(pseudo, {href: '#', onclick:"return ShowPersonnage('#{id}')"})
  end

  # Retourne le code HTML pour la fiche du personnage
  def as_fiche
    div(
      closebox("return HideCurFiche()") +
      div(pseudo, class: 'titre') +
      div(self.to_html, class: 'description'),
      {class: 'fiche personnage hidden', id: "fiche-personnage-#{id}"}
    )
  end

  def to_html
    c = String.new
    fonction    && c << libval('Fonction', fonction_displayed)
    annee       && c << libval('Année de naissance', annee)
    description && c << libval('Description', description_displayed)
    return c
  end

  def fonction_displayed
    c = Film::Personnage.traite_balises_in(fonction)
    return c
  end

end #/Personnage
end #/Film
