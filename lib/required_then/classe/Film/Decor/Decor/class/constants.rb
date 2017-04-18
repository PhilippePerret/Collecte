# encoding: UTF-8
class Film
class Decor

  # Définition des propriétés des décors, notamment pour
  # leur extraction au format brut.
  PROPERTIES = {
    id:           { value: nil},
    decor:        { value: nil},
    sous_decor:   { value: nil},
    lieu:         { value: nil},
    scenes_ids:   { value: :join, args: ','}
  }
end #/Decor
end #/Film
