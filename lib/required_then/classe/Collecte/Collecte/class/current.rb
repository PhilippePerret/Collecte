class BadCollecteFolder < StandardError ; end

class Collecte
class << self
  # {Collecte} La collecte courante, pour qu'elle soit
  # accessible de partout avec `Collecte.current`
  attr_accessor :current


  # Lors de l'appel par la commande `collecte`, cette
  # méthode vérifie qu'un dossier de collecte soit bien
  # accessible. Ce dossier peut être précisé soit parce
  # que c'est le dossier courant, soit parce qu'il a
  # été donné dans la commande (en dernier argument).
  #
  # Si on a bien un dossier de collecte, on renvoie true,
  # sinon on renvoie false ce qui lève une exception.
  #
  def check_collecte_folder
    @command_folder ||= CURRENT_FOLDER
    # Le dossier doit exister
    File.exist?(@command_folder) || raise(BadCollecteFolder, "Le dossier de collecte `#{@command_folder}` est introuvable…")
    # Le dossier doit contenir des fichiers typiques d'une
    # collecte et notamment, surtout, le fichier scènes
    fscenes = File.join(@command_folder, 'scenes.collecte')
    File.exist?(fscenes) || raise(BadCollecteFolder,  "Le dossier courant (`#{@command_folder}`) n’est pas un dossier de collecte.")
    return true
  rescue BadCollecteFolder => e
    puts "### ERREUR : #{e.message}"
    return false
  end
end #/<< self
end #/Collecte
