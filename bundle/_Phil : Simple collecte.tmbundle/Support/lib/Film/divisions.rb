# encoding: UTF-8
RC = <<-EOT

EOT
class Film
class << self

  def divisions_file
    @divisions_file ||= File.join(folder, 'divisions.txt')
  end

  # Ouvrir le fichier contenant les divisions du film et
  # les calcule si nécessaire (si le fichier n'existe pas.)
  def open_file_divisions forcer = false
    if forcer && File.exist?(divisions_file)
      File.unlink divisions_file
    end
    File.exist?(divisions_file) || calcule_and_save_divisions
    `mate "#{divisions_file}"`
  end

  # Calcule les divisions et les écrit dans un fichier
  # `divisions.txt` placé dans le dossier de la collecte
  def calcule_and_save_divisions
    File.open(divisions_file,'wb'){|f| f.write divisions}
  end

  # Code de la collecte
  def code_collecte
    @code_collecte ||= STDIN.read
  end

  def debut_film
    @debut_film ||= begin
      if collecte_simple?
        # En mode de collecte simple
        # Dans ce mode, on prend la première horloge de
        # scène qui se présente
        code_collecte.match(/^([0-9]:[0-9][0-9]?:[0-9][0-9]?) /).to_a[1].strip
      else
        # En mode de collecte "complet"
        code_collecte.match(/^SCENE:(.*)$/).to_a[1].strip
      end
    end
  end
  def fin_film
    @fin_film ||= begin
      if collecte_simple?
        code_collecte.scan(/^([0-9]:[0-9][0-9]?:[0-9][0-9]?)/).to_a.last.first
      else
        code_collecte.match(/^FIN:(.*)$/).to_a[1].strip
      end
    end
  end

  # Méthode qui affiche en sortie les divisions logiques
  # du film, pour l'établissement du paradigme de Field
  # augmenté, notamment.
  def divisions
    @divisions ||= begin
      cc = Array.new # Temps dans la collecte
      ca = Array.new # Temps absolus
      cc << "==== CALCUL DES POSITIONS DES DIVISIONS ===="
      cc << "==== (temps dans la collecte)           ===="
      ca << "==== CALCUL DES POSITIONS DES DIVISIONS ===="
      ca << "==== (temps absolus)                    ===="
      duree = h2s(fin_film) - h2s(debut_film)
      debut_secondes = h2s(debut_film)
      cc << "\tDébut : #{debut_film}"
      ca << "\tDébut : 0:00:00"
      cc << "\tFin   : #{fin_film}"
      ca << "\tFin   : #{s2h( h2s(fin_film) - debut_secondes)}"
      cc << "\tDurée : #{s2h duree}"
      ca << "\tDurée : #{s2h duree}"

      # === les tiers ===
      tiers = duree.to_f / 3
      cc << "------------- Tiers ------------"
      ca << "------------- Tiers ------------"
      cc << "\t1/3 à #{s2h(tiers + debut_secondes)}"
      ca << "\t1/3 à #{s2h(tiers)}"
      cc << "\t2/3 à #{s2h(2*tiers + debut_secondes)}"
      ca << "\t2/3 à #{s2h(2*tiers)}"

      # ======= Quarts ===========
      cc << "------------ Quarts ------------"
      ca << "------------ Quarts ------------"
      cc << "\t1/4 (développement) : #{s2h(duree/4 + debut_secondes)}"
      ca << "\t1/4 (développement) : #{s2h(duree/4)}"
      cc << "\t1/2 (clé de voûte)  : #{s2h(duree / 2 + debut_secondes)}"
      ca << "\t1/2 (clé de voûte)  : #{s2h(duree / 2)}"
      cc << "\t3/4 (dénouement)    : #{s2h(3*duree/4 + debut_secondes)}"
      ca << "\t3/4 (dénouement)    : #{s2h(3*duree/4)}"

      # === Cinquième ===
      cinquieme = duree.to_f / 5
      cc << "---------- Cinquièmes ---------"
      ca << "---------- Cinquièmes ---------"
      (1..5).each do |i|
        cc << "\t#{i}/5 à #{s2h(i*cinquieme + debut_secondes)}"
        ca << "\t#{i}/5 à #{s2h(i*cinquieme)}"
      end
      cc << "="*40

      cc.join(RC) + RC*3 + ca.join(RC)
    end
  end

  # ----------------------------------------------------
  #   Méthodes fonctionnelles
  # ----------------------------------------------------
  def h2s horloge
    scs, mns, hrs = horloge.split(':').reverse
    hrs.to_i * 3600 + mns.to_i * 60 + scs.to_i
  end

  def s2h secondes
    s = secondes.to_i
    hrs = s / 3600
    mns = s % 3600
    scs = (mns % 60).to_s.rjust(2,'0')
    mns = (mns / 60).to_s.rjust(2,'0')
    "#{hrs}:#{mns}:#{scs}"
  end

end #/<< self
end #/Film
