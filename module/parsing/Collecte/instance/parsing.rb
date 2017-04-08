# encoding: UTF-8
class Collecte

  # Méthode principale, appelé par `Collecte#parse`, pour
  # parser entièrement la collecte
  def parse_all
    prepare_parsing
    parse_metadata
    parse_brins
    parse_personnages
    parse_scenes
    termine_parsing
  end

  # ---------------------------------------------------------------------
  #   Sous-méthodes de parsing
  # ---------------------------------------------------------------------

  # Méthode qui lance le parsing des métadonnées
  def parse_metadata
    log "PARSING DES MÉTADONNÉES…"
    metadata.exist? || return
    metadata.parse
  rescue Exception => e
    log "au cours du parsing des métadonnées", error: e
  end

  # Méthode qui lance le parsing des brins
  def parse_brins
    log 'PARSING DES BRINS…'
    film.brins.parse
    film.brins.save
  rescue Exception => e
    log "au cours du parsing des brins", error: e
  end

  def parse_personnages
    log "PARSING DES PERSONNAGES…"
    film.personnages.parse
    film.personnages.save
  rescue Exception => e
    log "au cours du parsing des personnages", error: e
  end

  def parse_scenes
    log "PARSING DES SCÈNES…"
    log "\tParsing des scènes"
    film.scenes.parse
    log "\tCalcul de la durée des scènes"
    film.scenes.each{|ks, s| s.set_duree}
    log "\tSauvegarde des scènes"
    film.scenes.save
  rescue Exception => e
    log "au cours du parsing des scènes", error: e
  end

  #
  # ---------------------------------------------------------------------
  #

  def prepare_parsing
    # Il faut préparer le dossier `parsing` et le
    # dossier `data`
    FileUtils.rm_rf(data_folder)     if File.exist?(data_folder)
    build_data_folder
    # Initialisation des scènes
    Film::Scene.init
    log "Parsing préparé avec succès."
  rescue Exception => e
    log "ERREUR AU COURS DE LA PRÉPARATION DU PARSING", fatal_error: e
  end
  # /prepare_parsing


  # Méthode pour terminer le parsing des fichiers de
  # collecte.
  # Cette méthode fait principalement deux choses :
  #   1. Elle affiche un message final (par le biais
  #      d'un message HTML sur le browser)
  #   2. Elle construit un listing de toutes les données
  #      obtenues. Pour vérification.
  #
  # NOTES
  #   * On ne fait la confirmation
  def termine_parsing
    confirmation_parsing
  rescue Exception => e
    log 'à la fin du parsing', fatal_error: e
    raise e.message
  end

  def build_data_folder
    Dir.mkdir(data_folder, 0755)
  end

end #/Collecte
