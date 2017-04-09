# encoding: UTF-8
=begin
  Classe principale d'un objet relatif
=end
module RelativeObjectMethods

  def titre_displayed
    c = Film::Personnage.traite_balises_in(titre)
    return c
  end
  def libelle_displayed
    c = Film::Personnage.traite_balises_in(libelle)
    return c
  end

  def description_displayed
    c = Film::Personnage.traite_balises_in(description)
    return c
  end


end #/ RelativeObject
