class Film
class Scene

  PROPERTIES = {
    id:               { value: nil },
    numero:           { value: nil },
    horloge:          { value: :horloge },
    resume:           { value: :to_hash },
    effet:            { value: nil },
    effet_alt:        { value: nil },
    decors_ids:       { value: :join, args: ','},
    personnages_ids:  { value: :join, args: ','},
    brins_ids:        { value: :join, args: ','},
    notes_ids:        { value: :join, args: ','},
    scenes_ids:       { value: :join, args: ','}
  }

end #/Scene
end #/Film
