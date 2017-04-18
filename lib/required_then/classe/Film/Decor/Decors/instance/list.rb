# encoding: UTF-8
class Film
class Decors

  # Les méthodes communes
  # Cf. le module dans :
  # ./lib/required_first/module/list_elements_methods
  include ListElementsMethods

  # Pour les décors, il faut pouvoir en récupérer par
  # le décor lui-même, par exemple pour savoir s'il est
  # déjà utilisé. On se sert de cette méthode
  def get_by_decor decor, sous_decor
    hash != nil || (return nil)
    hash.each do |did, idecor|
      if idecor.decor == decor && idecor.sous_decor == sous_decor
        # Même décor et même sous-décor, c'est donc
        # l'instance décor qu'on cherche.
        return idecor
      end
    end
    # Noter que pour le moment, ici, on renvoie nil même
    # si le décor parent a été trouvé (decor) mais avec un
    # autre sous_decor. On considère que tout décor est différent
    # même si le décor parent est la même, à partir du moment où
    # le sous-décor est différent, même nil.
    return nil
  end


end #/Decors
end #/Film
