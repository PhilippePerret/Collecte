# encoding: UTF-8
class Film

  # {String} Identifiant du film dans le Filmodico
  # Pour le moment, ne peut être défini qu'explicitement.
  attr_accessor :id

  # {String} Titre pour mémoire
  attr_reader :titre

  # {Array de String|Fixnum} Auteurs
  attr_reader :auteurs

  # Instance {Collecte} rattachée au film
  #
  # Par exemple, pour obtenir le dossier de la collecte, on
  # peut faire `film.collecte.folder`
  attr_reader :collecte


end #/Film
