# encoding: UTF-8

module ListElementsMethods

  # Instance {Film} qui contient l'instance des élements.
  # Cette propriété doit être définie à l'instanciation.
  attr_reader :film

  # {Hash} Tableau des éléments du film, avec en clé l'ID
  # de l'élément et en valeur son instance, en fonction du
  # type d'élément ({Film::Brin} pour les brins, par exemple)
  #
  # NOTE On peut obtenir ces éléments en faisant :
  #   film.<element pluriel>[<id de l'élément>]
  #   ou
  #   film.<element pluriel>.hash[<id de l'élément>]
  # Par exemple, pour les brins :
  #   film.brins[<id du brin>]
  #   ou
  #   film.brins.hash[<id du brin>]
  #
  attr_reader :hash

end
