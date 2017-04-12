# encoding: UTF-8
#
# GESTION DU FICHIER MARSHAL film.msh
class Film

  # Charger les données, mais seulement si elles
  # existent
  # Retourne TRUE si le fichier marshal existe et FALSE
  # dans le cas contraire.
  def load_if_exist
    if File.exist?(marshal_file)
      load
      return true
    else
      return false
    end
  end

  # Charger les données du fichier Marshal
  def load
    log "-> Film#load…"
    File.exist?(marshal_file) || raise('Impossible de charger les données du film : le film `data/film.msh` n’existe pas.')
    @donnee_totale = Marshal.load(File.read(marshal_file))
    dispatch
    log "<- Film#load OK"
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
    [:Note, :Personnage, :Brin, :Scene].each do |elclass|
      elkey   = "#{elclass.to_s.downcase}s".to_sym # p.e. :notes
      classe  = Object.const_get("Film::#{elclass}")

      # Le hash qui sera mis dans @hash des objets.
      hash = Hash.new

      #
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
