# encoding: UTF-8
class Film

  # Raccourcis vers les METADATA
  # ----------------------------
  def metadata ; @metadata ||= collecte.metadata.data end
  # {String} Identifiant du film dans le Filmodico
  # Pour le moment, ne peut être défini qu'explicitement.
  def id    ; @id     ||= metadata[:id]    end
  # {String} Titre pour mémoire
  def titre ; @titre  ||= metadata[:titre] end


  # {Fixnum} Temps de création du fichier film.msh
  # ou du fichier film.pstore
  # Attention : ne correspond pas au début de la collecte,
  # enregistrée elle dans collecte.debut ou
  # collecte.metadata.data[:debut] sous forme de JJ/MM/AAAA
  attr_accessor :created_at
  # {Fixnum} Time d'actualisation du fichier de données
  attr_accessor :updated_at

  # Instance {Collecte} rattachée au film
  #
  # Par exemple, pour obtenir le dossier de la collecte, on
  # peut faire `film.collecte.folder`
  attr_reader :collecte

  # {Film::Horloge} Temps de fin du film
  # Il devrait être défini par une ligne `HORLOGE FIN` mais
  # au cas où, on prend le temps de la dernière scène à
  # laquelle on ajoute une minute.
  def fin= value
    value.instance_of?(Film::Horloge) || value = Film::Horloge.new(self, value.s2h)
    @fin = value
  end
  def fin
    @fin ||= Film::Horloge.new(self, (scenes.last.horloge.time + 60).s2h)
  end
  alias :end :fin

  # {Film::Horloge} Temps de départ du film
  # Note : ce temps correspond au temps de la première
  # scène de la collecte
  def debut ; @debut ||= scenes.first.horloge end
  alias :start :debut

  # {Fixnum} Durée du film
  def duree
    @duree ||= fin.time - debut.time
  end


end #/Film
