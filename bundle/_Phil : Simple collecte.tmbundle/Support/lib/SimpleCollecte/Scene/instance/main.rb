# encoding: UTF-8
class SimpleCollecte
class Scene

  # Décalage naturel entre le début réel de la scène et le
  # moment où on l'initie dans le fichier de collecte. Il y
  # forcément un décalage (ce nombre de secondes) qui est
  # aussitôt retiré au temps de la scène.
  # Par exemple, si la scène débute à 0:22:23, on compte qu'on
  # réagira en retard pour la créer et qu'elle sera créée en
  # fait à 0:22:26, donc 3 secondes plus tard. On retire donc
  # ces trois secondes pour obtenir le temps correct.
  OFFSET_DEBUT_SCENE = 3

  # Le temps est arrondi de 5 secondes en 5 secondes grâce
  # à cette variable.
  # Note : mettre à nil pour ne pas arrondir le temps
  ROUND_TIME = 5 # secondes

  def initialize
    # On calcule le time de la scène à son instanciation
    # Ce temps est calculé d'après le fichier START_COLLECTE.txt
    # qui est enregistré
    horloge
  end

  # Temps de la scène
  def horloge
    @horloge ||= begin
      if File.exist?(SimpleCollecte.start_file)
        htime = SimpleCollecte.start_time
        diff_time = Time.now.to_i() -htime[:time] -OFFSET_DEBUT_SCENE
            # Note : à propos du OFFSET_DEBUT_SCENE ci-dessus,
            # voir la définition de la constante plus haut.
        diff_time < 4*3600 || begin
          raise "La collecte doit être relancée. L'intervale de temps est trop grand par rapport au démarrage enregistré."
        end
        curr_time = htime[:start] + diff_time
        # On arrondit le temps courant de 10 en 10
        if ROUND_TIME
          curr_time = (curr_time.to_f / ROUND_TIME).round * ROUND_TIME
        end
        h = curr_time / 3600
        r = curr_time % 3600
        m = r / 60
        s = r % 60
        s > 9 || s = "0#{s}"
        m > 9 || m = "0#{m}"
        # L'horloge mise dans @horloge
        "#{h}:#{m}:#{s}"
      else
        nil
      end
    end
  end
end #/Scene
end #/SimpleCollecte
