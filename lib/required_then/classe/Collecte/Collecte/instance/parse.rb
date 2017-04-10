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
  #
  # +options+
  #     :debug      Si true, on ouvre le fichier journal
  #                 à la fin du parsing.
  #                 Noter qu'il sera de toutes façon toujours
  #                 ouvert lorsqu'une erreur survient.
  def parse options = nil
    options ||= Hash.new
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
    if (errors != nil && errors.count > 0) || options[:debug]
      Log.build_and_open_html_file
    end
  end

end
