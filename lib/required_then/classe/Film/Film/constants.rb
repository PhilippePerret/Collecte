# encoding: UTF-8
class Film

  # Mode de sauvegarde et de chargement des données, soit
  # par PStore soit par Marshal (:marshal).
  # Les deux données permettent simplement de faire une
  # transition pour passer de l'une à l'autre. Si l'une
  # existe, on met le mode MODE_DATA_LOAD à ce type et
  # l'autre à l'autre type puis on passe MODE_DATA_LOAD
  # à l'autre type.
  # Lorsque les deux types sont différents, on sait qu'on
  # doit sauver les données dans l'autre type après
  # chargement du film.
  MODE_DATA_LOAD = :pstore # ou :marshal
  MODE_DATA_SAVE = :pstore # ou :marshal

end
