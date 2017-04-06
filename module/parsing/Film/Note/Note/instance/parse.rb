# encoding: UTF-8
class Film
class Note

  # Méthode pour parser
  def parse bloc
    id, texte = bloc.match(/^\(([0-9]+)\) (.*?)$/).to_a[1..-1]
    # L'identifiant a dû être déjà défini lors du tout
    # premier appel de la note, mais on peut le remettre
    # ici
    @id = id.to_i
    # Le texte en texte-objet
    @content = Film::TextObjet.new(film)
    @content.parse(texte.strip)
  end

end #/Note
end #/Film
