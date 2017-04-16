# encoding: UTF-8
class Film
class Decor

  def to_hash
    {
      id:             id,
      decor:          decor,
      decor_parent:   decor_parent,
      sous_decor:     sous_decor,
      lieu:           lieu,
      scenes_ids:     scenes_ids
    }
  end


  # Décompose si nécessaire le décor en son décor parent
  # et son sous-decor
  def decompose_decor
    decor.match(/:/) || return
    decs = decor.split(':')
    @decor_parent = decs.shift.strip
    @sous_decor   = decs.join(':').strip
    # Si le décor parent existe déjà, on prend son identifiant,
    # sinon, on crée un nouveau décor parent
    
  end
end #/Decor
end #/Film
