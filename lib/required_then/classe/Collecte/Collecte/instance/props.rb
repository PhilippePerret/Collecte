# encoding: UTF-8
class Collecte

  # Métadonnées
  # ===========
  # Liste des auteurs (pour le moment, array de pseudos)
  attr_accessor :auteurs
  # Date JJ/MM/AAAA de début et de fin de la collecte
  attr_accessor :debut, :fin

  # L'instance {Film} du film de la collecte
  def film ; @film ||= Film.new(self) end

  # {Array} Liste des erreurs rencontrées au cours de
  # l'opération.
  attr_reader :errors

  # Instance Collecte::Metadata des métadonnées
  def metadata  ; @metadata ||= Metadata.new(self)  end

  # Raccourcis vers les METADATA
  # ----------------------------
  def auteurs ; @auteurs  ||= metadata.data[:auteurs] end
  def debut   ; @debut    ||= metadata.data[:debut]   end
  def fin     ; @fin      ||= metadata.data[:fin]     end

end
