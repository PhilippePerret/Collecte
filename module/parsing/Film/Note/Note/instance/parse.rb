# encoding: UTF-8
class Film
class Note

  # Méthode pour parser
  def parse bloc
    puts "bloc : #{bloc.inspect}"
    puts "bloc.match(/^\(([0-9]+)\) (.*?)$/).to_a : #{bloc.match(/^\(([0-9]+)\) (.*?)$/).to_a.inspect}"
    tout, id, texte = bloc.match(/^\(([0-9]+)\) (.*?)$/).to_a
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
