# encoding: UTF-8
class Film
class Brin

  # Méthode pour parser
  def parse bloc
    arr = bloc.split(RC)
    @id          = arr.shift.to_i
    @id > 0 || raise(BadBlocData, "Impossible de parser le brin défini par #{bloc.inspect} : il manque l'identifiant numérique.")
    @libelle     = arr.shift.nil_if_empty
    @libelle != nil || raise(BadBlocData, "Le libellé du brin doit être fourni (dans #{bloc.inspect}).")
    @libelle = Film::TextObjet.new(film).parse(@libelle)
    @description = arr.join(RC).nil_if_empty
    @description.nil? || @description = Film::TextObjet.new(film).parse(@description)
  end

end #/Brin
end #/Film
