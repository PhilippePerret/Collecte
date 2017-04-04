# encoding: UTF-8
class Film
class Note

  # {Film} Instance du film auquel appartient la note
  attr_reader :film

  # {String} Identifiant absolu de la note
  attr_reader :id

  # {Fixnum} Identifiant de la scène à laquelle appartient
  # la note
  attr_reader :scene_id

  # {TextObjet} Le contenu de la note, en texte-objet
  attr_reader :content

end #/Note
end #/Film
