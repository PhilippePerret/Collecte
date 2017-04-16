# encoding: UTF-8
class Film
class Scene

  # Les données qui seront enregistrées dans le fichier
  # marshal.
  def to_hash
    hor = horloge.nil? ? nil : horloge.to_hash
    res = resume.nil? ? nil : resume.to_hash
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
      paragraphes:      paragraphes_as_to_hash,
      notes_ids:        notes_ids,
      stt_points_ids:   stt_points_ids
    }
  end

  # Les paragraphes pour l'enregistrement
  def paragraphes_as_to_hash
    (@paragraphes||[]).collect{|p|p.to_hash}
  end

end #/Scene
end #/Film
