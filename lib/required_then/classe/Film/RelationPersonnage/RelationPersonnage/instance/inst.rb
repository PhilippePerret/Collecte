# encoding: UTF-8
class Film
class RelationPersonnage

  include RelativeObjectMethods

  # +arr_persos+ Liste des identifiants des personnages
  # ou liste des personnages de cette relation
  def initialize film, id, arr_persos
    @film = film
    @id   = id || arr_persos.sort_by{|n|n}.join('_')

    @personnages_ids = Array.new
    arr_persos.each do |perso_id|
      # Si ce n'est pas l'ID string du personnage, c'est une
      # instance Film::Personnage, on prend alors son ID
      perso_id.instance_of?(String) || perso_id = perso_id.id
      @personnages_ids << perso_id
    end
  end

end #/RelationPersonnage
end #/Film
