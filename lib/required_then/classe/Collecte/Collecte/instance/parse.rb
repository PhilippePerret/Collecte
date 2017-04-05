# encoding: UTF-8
class Collecte

  # = main =
  #
  # Méthode principale pour procéder au parsing du dossier de
  # collecte.
  #
  # NOTES
  #   * En fin de parsing, on sauve toutes les données
  #     dans le fichier data/film.msh qui contient tout.
  def parse
    Collecte.load_module 'parsing'
    parse_all
    # On sauve tout
    film.save
  end

end
