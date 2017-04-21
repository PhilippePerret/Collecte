# encoding: UTF-8
class Film
class Personnage
class << self

  # Traite les balises [PERSO#<id>] dans +code+
  def traite_balises_in code
    code.gsub(/\[PERSO\#(.*?)\]/){
      pid = $1
      perso = film.personnages[pid]
      perso != nil || begin
        # Maintenant que le check est fait au parse du
        # fichier ou à l'enregistrement des données,
        # le personnage existe forcément. Il ne peut donc
        # pas être nil
      end
      perso.as_link
    }
  end

end #/<< self
end #/Personnage
end #/Film
