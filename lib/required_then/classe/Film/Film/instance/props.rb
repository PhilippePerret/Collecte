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
  # Attention : ne correspond pas au début de la collecte,
  # enregistrée elle dans collecte.debut ou
  # collecte.metadata.data[:debut] sous forme de JJ/MM/AAAA
  attr_accessor :created_at

  # Instance {Collecte} rattachée au film
  #
  # Par exemple, pour obtenir le dossier de la collecte, on
  # peut faire `film.collecte.folder`
  attr_reader :collecte

  # {Film::Horloge} Temps de fin du film
  def fin ; @fin ||= scenes.last.horloge end
  alias :end :fin

  # {Film::Horloge} Temps de départ du film
  # Note : ce temps correspond au temps de la première
  # scène de la collecte
  def start ; @debut ||= scenes.first.horloge end
  alias :debut :start

  # {Fixnum} Durée du film
  def duree
    @duree ||= begin
      scenes.last.horloge.time - scenes.first.horloge.time
    end
  end


end #/Film
