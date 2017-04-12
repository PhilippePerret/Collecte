# encoding: UTF-8
class Film
class Scene

  # Les données qui seront enregistrées dans le fichier
  # marshal.
  def hash_data
    hor = horloge.nil? ? nil : horloge.hash_data
    res = resume.nil? ? nil : resume.hash_data
    # TODO Mais contrôler la ligne ci-dessus car ça ne
    # devrait pas arriver que le résumé n'existe pas.
    if resume.nil?
      raise BadBlocData, "Le bloc de scène ne définit pas de résumé :#{RC}#{bunch_code.inspect}"
    end
    {
      id:               id,
      numero:           numero,
      line:             line,
      horloge:          hor,
      resume:           res,
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
      notes_ids:        notes_ids
    }
  end

  # Les paragraphes pour l'enregistrement
  def paragraphes_as_hash_data
    (@paragraphes||[]).collect{|p|p.hash_data}
  end

end #/Scene
end #/Film
