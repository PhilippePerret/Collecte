# encoding: UTF-8
class Collecte

  # = main =
  #
  # Méthode principale pour procéder au parsing du dossier de
  # collecte.
  #
  def parse
    Collecte.load_module 'parsing'
    prepare_parsing
    parse_brins
    parse_personnages
    parse_scenes
  end

end
