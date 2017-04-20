# encoding: UTF-8
#
# GESTION DU FICHIER MARSHAL film.msh
class Film

  # Charger les données, mais seulement si elles
  # existent
  # Retourne TRUE si le fichier marshal existe et FALSE
  # dans le cas contraire.
  def load_if_exist
    if MODE_DATA_LOAD == :marshal
      if File.exist?(marshal_file)
        load_from_marshal
        resultat = true
      else
        resultat = false
      end
    elsif MODE_DATA_LOAD == :pstore
      # Version avec PStore
      if File.exist?(pstore_file)
        load_from_pstore
        resultat = true
      else
        resultat = false
      end
    else
      raise "Le mode de chargement des données #{MODE_DATA_LOAD.inspect} (MODE_DATA_LOAD) est inconnu. Impossible de charger les données du film."
    end

    # Si le mode de chargement est différent du mode de
    # sauvegarde, il faut sauver les données dans ce nouveau
    # mode. Cela permet de passer d'un mode à un autre.
    if MODE_DATA_LOAD != MODE_DATA_SAVE
      save
    end

    # Les opérations qu'il faut faire au chargement des
    # données, à propos des données volatiles
    # =================================================
    # Définir les relations de personnages
    relations_personnages.define

    return resultat
  end
  alias :load :load_if_exist


  def load_from_marshal
    log "-> load_from_marshal"
    File.exist?(marshal_file) || raise('Impossible de charger les données du film : le film `data/film.msh` n’existe pas.')
    @donnee_totale = Marshal.load(File.read(marshal_file))
    dispatch
    log "<- load_from_marshal"
  end

  def load_from_pstore
    log "-> Film#load_from_pstore"
    destore_metadata
    [:personnage, :brin, :note, :scene, :decor].each do |ktype|
      destore_data ktype
    end
    log "<- Film#load_from_pstore OK"
  end

  # Chargement des métadonnées du film depuis le PStore
  def destore_metadata
    pstore.transaction do |ps|
      collecte.metadata.data = ps[:metadata]
      self.created_at =  ps[:created_at]
      self.updated_at =  ps[:updated_at]
    end
  end

  # Chargement des objets relatifs depuis le fichier PStore
  # du film
  def destore_data type
    classe  = Object.const_get("Film::#{type.capitalize}")
    pstore.transaction do |ps|
      ps[type][:items].each do |oid, odata|
        # On crée une instance du type voulu
        instance = classe.new(self)
        # On dispatche toutes les données dans l'instance
        # créée
        instance.dispatch(odata)
        # On ajoute cette instance à la liste des
        # instances de ce type.
        self.send("#{type}s".to_sym) << instance
      end
    end
  end


  def dispatch
    log "-> Film#dispatch"

    # log "donnee_totale = #{donnee_totale.inspect}"

    # METADATA
    # --------
    # Elles seront ensuite dispatchées progressivement à l'aide
    # des raccourcis qui font tous appels à collecte.metadata.data
    collecte.metadata.data = donnee_totale[:metadata]
    # log "#{RC}donnee_totale[:metadata]: #{donnee_totale[:metadata].inspect}"

    # ÉLÉMENTS
    # --------
    [:Note, :Personnage, :Brin, :Scene, :Decor].each do |elclass|
      elkey   = "#{elclass.to_s.downcase}s".to_sym # p.e. :notes
      classe  = Object.const_get("Film::#{elclass}")

      # Le hash qui sera mis dans @hash des objets.
      hash = Hash.new

      # La liste des objets relatifs elkey. Par exemple
      # la liste des scènes (mais c'est un Hash qui contient
      # en fait la clé :items où sont mis les éléments)
      data_items = donnee_totale[elkey]
      data_items != nil || begin
        next
      end

      # On boucle sur chaque liste d'items, mais
      # seulement si elle existe.
      lesitems = data_items[:items]
      lesitems.instance_of?(Hash) || begin
        next
      end
      lesitems.each do |item_id, hitem|
        el = classe.new(self)
        el.dispatch hitem
        hash.merge!(el.id => el)
      end

      self.send(elkey).instance_variable_set('@hash', hash)
    end

    # DATES
    # -----
    @created_at = donnee_totale[:created_at]

    log "<- Film#dispatch OK"
  end

end #/Film
