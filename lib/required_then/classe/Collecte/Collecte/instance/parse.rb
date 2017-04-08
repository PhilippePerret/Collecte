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
    # Si le fichier `film.msh` n'a pas été produit,
    # il faut signaler une erreur
    File.exist?(film.marshal_file) || raise('Le fichier data `film.msh` n’a pas été produit. La collecte n’a pas abouti.')
  rescue Exception => e
    log 'à la fin de Collecte#parse', fatal_error: e
  ensure
    if errors != nil && errors.count > 0
      puts "Des erreurs ont été produites (#{errors.count}). Consulter le fichier `process.log`"
    end
  end

end
