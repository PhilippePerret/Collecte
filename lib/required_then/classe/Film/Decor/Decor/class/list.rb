# encoding: UTF-8
class Film
class Decor
class << self

  # {Hash} qui permet d'obtenir l'ID {Fixnum} d'un décor
  # (parent) à partirde son libellé
  attr_reader :decor_to_id

  # Ajouter un décor parent à la liste des parents, notamment
  # pour obtenir la table qui permet d'avoir l'ID à partir du
  # nom du décor
  def add_decor_parent decor
    @decor_to_id.merge(decor.decor => decor.id)
  end

  # Pour obtenir un nouvel identifiant pour un brin
  def new_id
    @last_id ||= 0
    @last_id += 1
  end

end #/<< self
end #/Decor
end #/Film
