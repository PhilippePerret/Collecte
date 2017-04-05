# encoding: UTF-8
#
# GESTION DU FICHIER MARSHAL film.msh
class Film

  # Charger les données, mais seulement si elles
  # existent
  def load_if_exist
    File.exist?(marshal_file) && load
  end

  # Charger les données du fichier Marshal
  def load
    log "->LOADING FILM…"
    File.exist?(marshal_file) || raise('Impossible de charger les données du film : le film `data/film.msh` n’existe pas.')
    @donnee_totale = Marshal.load(File.read(marshal_file))
    dispatch
    log "<-LOADING OK"
  end

  def dispatch

    log "donnee_totale = #{donnee_totale.inspect}"

    # METADATA
    # --------
    # Elles seront ensuite dispatchées progressivement à l'aide
    # des raccourcis qui font tous appels à collecte.metadata.data
    collecte.metadata.instance_variable_set('@data', donnee_totale[:metadata])

    # ÉLÉMENTS
    # --------
    [:Note, :Personnage, :Brin, :Scene].each do |elclass|
      elkey   = "#{elclass.to_s.downcase}s".to_sym # p.e. :notes
      classe  = Object.const_get("Film::#{elclass}")

      # Le hash qui sera mis dans @hash des objets.
      hash = Hash.new

      #
      data_items = donnee_totale[elkey]
      log "data_items de #{elkey.inspect} : #{data_items.inspect}"
      data_items != nil || begin
        log "Donnée #{elkey.inspect} non définie"
        next
      end

      # On boucle sur chaque liste d'items, mais
      # seulement si elle existe.
      lesitems = data_items[:items]
      lesitems.instance_of?(Hash) || begin
        log "Pas de #{elkey} définis"
        next
      end
      log "Loading les #{elkey}…"
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
  end

end #/Film
