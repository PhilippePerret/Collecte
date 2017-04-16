class Film
class Scene

  PROPERTIES = {
    id:               { value: nil },
    numero:           { value: nil },
    horloge:          { value: :horloge },
    resume:           { value: :to_hash },
    effet:            { value: nil },
    effet_alt:        { value: nil },
    lieu:             { value: nil },
    lieu_alt:         { value: nil },
    decor:            { value: nil },
    decor_alt:        { value: nil },
    personnages_ids:  { value: :join, args: ','},
    brins_ids:        { value: :join, args: ','},
    notes_ids:        { value: :join, args: ','},
    scenes_ids:       { value: :join, args: ','}
  }

end #/Scene
end #/Film
