# encoding: UTF-8
class Film
class Personnage
class << self

  # Pour les tests
  # Film::Personnage.init
  def init
    @film = nil
  end

  def film
    @film ||= Collecte.current.film
  end

  # Retourne la liste des identifiants de personnages contenue
  # dans le code +code+
  # Rappel : les identifiants des personnages sont des Strings
  # +code+ peut être un string ou un Film::TextObjet
  def personnages_ids_in code
    code.instance_of?(String) || code = code.raw
    code.scan(/\[PERSO\#(.*?)\]/).to_a.collect do |found|
      perso_id = found[0] # rappel : un string
      film.personnages[perso_id] != nil || raise("Le personnage d’identifiant ##{perso_id} est inconnu. Il faut le définir dans le fichier personnages.collecte")
      perso_id
    end
  end

end #/<< self
end #/Personnage
end #/Film
