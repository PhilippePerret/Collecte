# encoding: UTF-8
class Film
class Personnage
class << self

  def film
    @film ||= Collecte.current.film
  end

  # Traite les balises [PERSO#<id>] dans +code+
  def traite_balises_in code
    code.gsub(/\[PERSO\#(.*?)\]/){
      pid = $1
      perso = film.personnages[pid]
      perso != nil || raise("Impossible d'obtenir le personnage ##{pid}. Il faut le définir impérativement.")
      perso.as_link
    }
  end

end #/<< self
end #/Personnage
end #/Film
