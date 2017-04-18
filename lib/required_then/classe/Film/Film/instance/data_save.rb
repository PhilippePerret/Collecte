# encoding: UTF-8
#
# GESTION DU FICHIER MARSHAL film.msh
class Film

  # Sauver les données dans le fichier marshal
  def save
    if MODE_DATA_SAVE == :marshal
      #
      # => Chargement en version MARSHAL
      #
      marshal_save
    elsif MODE_DATA_SAVE == :pstore
      #
      # => Chargement en version PSTORE
      #
      pstore_save
    else
      raise "Le mode de sauvegarde #{MODE_DATA_SAVE.inspect} (MODE_DATA_SAVE) est inconnu."
    end
  end

  # Sauve dans un fichier Marshal
  def marshal_save
    donnee_totale.merge!(updated_at: Time.now.to_i)
    # log "DATA FILM ENREGISTRÉES (film#donnee_totale) :#{RC}#{donnee_totale.inspect}"
    File.open(marshal_file,'wb'){|f| f.write Marshal.dump(donnee_totale)}
  end

  # Sauve dans un PStore
  def pstore_save
    # Les métadonnées
    store_metadata
    # Scenes
    store_data :scene
    # Décors
    store_data :decor
    # Brins
    store_data :brin
    # Notes
    store_data :note
  end


  # Enregistrer les métadata du film dans le pstore
  def store_metadata
    pstore.transaction do |ps|
      ps[:metadata]   = metadata.merge(duree: duree)
      ps[:created_at] = ps[:created_at] || Time.now.to_i
      ps[:updated_at] = Time.now.to_i
    end
  end
  # +type+ peut être :scene, :brin, :note et :personnage
  def store_data type
    pstore.transaction do |ps|
      liste_ids_of_type = Array.new

      # On prépare la table qui va recevoir tous les
      # objets du type spécifié.
      ps[type] = {_ids_: nil, items: Hash.new}

      # On enregistre tous les objets du type
      self.send("#{type}s".to_sym).each do |oid, objet|
        ps[type][:items][oid] = objet.to_hash
        liste_ids_of_type << oid
      end

      # On enregistre la liste des IDs des objets du type
      # Par exemple la liste des IDs de personnage
      ps[type][:_ids_] = liste_ids_of_type
    end
  end

  def pstore
    @pstore ||= begin
      require 'pstore'
      ps = PStore.new(pstore_file)
      ps.ultra_safe = true
      ps
    end
  end

  # Renvoie un {Hash} de toutes les données du film
  # Noter que cette donnée NE SERT PAS quand on enregistre
  # les données dans un PStore.
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
      decors:         decors.data2save,
      # DATES
      # -----
      created_at:     (created_at || Time.now.to_i)
    }
  end


end #/Film
