# encoding: UTF-8

class Film
class TextObjet
class << self

  # Réinitialiser la classe Film::TextObjet
  # Note : surtout nécessaire pour les tests, où l'on peut
  # passer explicitement les options (utile lorsqu'on veut
  # se servir des méthodes comme `to_html` en dehors de
  # l'extraction)
  def init opts = nil
    @options = opts # même si nil
    @traiter_les_personnages = true
    @ajouter_les_relatifs    = options[:as] != :synopsis
  end

  def options
    @options ||= Collecte.current.extractor.options
  end

  def traite_personnages?
    @traiter_les_personnages
  end

  def add_relatifs?
    @ajouter_les_relatifs
  end

end #/<< self
end #/TextObjet
end #/Film
