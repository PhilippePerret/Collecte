# encoding: UTF-8
class Film
class Notes

  # Les méthodes communes
  # Cf. le module dans :
  # ./lib/required_first/module/list_elements_methods
  include ListElementsMethods


  # Redéfinit la méthode `[]` pour créer une instance
  # lorsque l'instance note n'existe pas.
  # Cela est nécessaire car, presque toujours, l'index
  # de la note est rencontré avant que la note ne soit
  # définie.
  #
  # Retourne l'élément d'identifiant +element_id+
  # Par exemple le brin, par `film.brins[12] #=> brin #12`
  def [] element_id
    # Ne pas utiliser la ligne suivante, pour simplifier les
    # test. Sinon, il faudrait toujours créer les éléments.
    # @hash != nil || raise("Aucun élément de type #{self.class.name} n'est défini.")
    @hash ||= Hash.new
    @hash.key?(element_id) || begin
      # Il faut instancier cette note qui n'existe pas
      # encore
      n = Film::Note.new(self.film)
      n.instance_variable_set('@id', element_id)
      @hash.merge!(element_id => n)
    end
    @hash[element_id]
  end

end #/Notes
end #/Film
