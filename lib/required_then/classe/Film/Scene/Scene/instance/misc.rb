# encoding: UTF-8
class Film
class Scene

  # Les données qui seront enregistrées dans le fichier
  # marshal.
  def hash_data
    hor = horloge.nil? ? nil : horloge.horloge
    {
      id:               id,
      numero:           numero,
      horloge:          hor,
      resume:           resume.hash_data,
      effet:            effet,
      effet_alt:        effet_alt,
      lieu:             lieu,
      lieu_alt:         lieu_alt,
      decor:            decor,
      decor_alt:        decor_alt,
      fonction:         fonction,
      brins_ids:        brins_ids,
      personnages_ids:  personnages_ids,
      paragraphes:      paragraphes_as_hash_data,
      notes:            notes_as_hash_data
    }
  end

  def paragraphes_as_hash_data
    (@paragraphes||[]).collect{|p| p.hash_data}
  end
  def notes_as_hash_data
    (@notes||[]).collect{|n|n.hash_data}
  end

end #/Scene
end #/Film
