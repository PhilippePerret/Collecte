# encoding: UTF-8
class Collecte

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
