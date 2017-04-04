# encoding: UTF-8
class SimpleCollecte
class << self
  
  # = main =
  #
  # Méthode appelée par la commande « Start collecte » du
  # bundle SimpleCollecte pour lancer la collecte.
  # Cela a pour effet d'enregistrer un fichier dans le 
  # dossier de collecte contenant le temps de départ de
  # la collecte, pour définir automatiquement les temps
  # des scènes créées.
  def start
    File.exist?(start_file) && File.unlink(start_file)
    now = Time.now.to_i
    input = STDIN.read
    horloge_start = input.strip.split(':')
    horloge_start.reverse!
    while horloge_start.count < 3
      horloge_start << 0
    end
    s, m, h = horloge_start.collect{|i|i.to_i}
    time_secondes = s + m*60 + h*3600
    puts "# Horloge de départ : #{horloge_start.reverse.join(':')}"
    puts "# Timestamp départ  : #{now}"
    File.open(start_file,'wb'){|f| f.write "#{now}:#{time_secondes}"}
  end
  
  # Retourne le temps de départ enregistré
  # C'est un duolet qui contient {:time, :start}
  # Où :
  #   :time   Est l'heure de lancement de la collecte
  #   :start  Est l'horloge de départ dans le film
  def start_time
    @start_time ||= begin
      File.exist?(start_file) || begin
        raise "La collecte n'a pas été lancée, impossible d'obtenir le temps de départ."
      end
      t, s = File.read(start_file).split(':').collect{|i|i.to_i}
      {time: t, start: s}
    end
  end
  
  def start_file
    @start_file ||= File.join(Film.folder, 'START_TIME.txt')
  end
end #/<< self
end # SimpleCollecte