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
    film.scenes.parse
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
    FileUtils.rm_rf(parsing_folder)  if File.exist?(parsing_folder)
    FileUtils.rm_rf(data_folder)     if File.exist?(data_folder)
    build_parsing_folder
    build_data_folder
    # Initialisation des scènes
    Film::Scene.init
    log "Parsing préparé avec succès."
  rescue Exception => e
    log "ERREUR AU COURS DE LA PRÉPARATION DU PARSING", fatal_error: e
  end
  # /prepare_parsing

  def build_parsing_folder
    Dir.mkdir(parsing_folder, 0755)
  end
  def build_data_folder
    Dir.mkdir(data_folder, 0755)
  end

end #/Collecte
