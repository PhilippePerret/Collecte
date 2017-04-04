# encoding: UTF-8
class Collecte

  # L'instance {Film} du film de la collecte
  def film
    @film ||= Film.new(self)
  end

  # {Array} Liste des erreurs rencontrées au cours de
  # l'opération.
  attr_reader :errors

end
