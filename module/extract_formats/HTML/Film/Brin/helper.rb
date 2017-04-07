# encoding: UTF-8
class Film
class Brin

  # Retourne le code HTML pour la fiche du brin
  def as_fiche
    div(
      closebox("return HideBrin(#{id})") +
      div(libelle, class: 'titre') +
      div(description, class: 'description'),
      {class: 'fiche brin hidden', id: "fiche-brin-#{id}"}
    )
  end

end #/Brin
end #/Film
