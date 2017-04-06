# encoding: UTF-8
#
# GESTION DU FICHIER MARSHAL film.msh
class Film

  # Renvoie un {Hash} de toutes les données du film
  def donnee_totale
    @donnee_totale ||= {
      # METADATA
      # --------
      id:             id,
      titre:          titre,
      metadata:       metadata, # = collecte.metadata.data
      # ÉLÉMENTS
      # --------
      scenes:         scenes.data2save,
      personnages:    personnages.data2save,
      brins:          brins.data2save,
      notes:          notes.data2save,
      # DATES
      # -----
      created_at:     (created_at || Time.now.to_i)
    }
  end

  # Sauver les données dans le fichier marshal
  def save
    donnee_totale.merge!(updated_at: Time.now.to_i)
    # log "DATA FILM ENREGISTRÉES (film#donnee_totale) :#{RC}#{donnee_totale.inspect}"
    File.open(marshal_file,'wb'){|f| f.write Marshal.dump(donnee_totale)}
  end

end #/Film
