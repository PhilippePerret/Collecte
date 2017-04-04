# encoding: UTF-8
class Film

  # {String} Identifiant du film dans le Filmodico
  # Pour le moment, ne peut être défini qu'explicitement.
  attr_accessor :id

  # Instance {Collecte} rattachée au film
  #
  # Par exemple, pour obtenir le dossier de la collecte, on
  # peut faire `film.collecte.folder`
  attr_reader :collecte


end #/Film
