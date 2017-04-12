# encoding: UTF-8
=begin
  Classe principale d'un objet relatif
=end
module RelativeObjectMethods

  def titre_displayed
    return Film::Personnage.traite_balises_in(titre)
  end
  def libelle_displayed
    return Film::Personnage.traite_balises_in(libelle)
  end
  def description_displayed
    return Film::Personnage.traite_balises_in(description)
  end

  # Retourne le lien pour voir l'objet dans TextMate si
  # la donnée @line est définie.
  def showinTM_link
    @line != nil || (return '')
    href = "txmt://open/?url=file://#{collecte_file}"
    href += "&line=#{line}&column=1"
    link('->TM', {href: href, class: 'tmlink'})
  end


end #/ RelativeObject
