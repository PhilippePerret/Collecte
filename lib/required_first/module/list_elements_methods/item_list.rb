module ListElementsMethods

  # {Hash} Tableau des éléments du film, avec en clé l'ID
  # de l'élément et en valeur son instance, en fonction du
  # type d'élément ({Film::Brin} pour les brins, par exemple)
  #
  # NOTE On peut obtenir ces éléments en faisant :
  #   film.<element pluriel>[<id de l'élément>]
  #   ou
  #   film.<element pluriel>.hash[<id de l'élément>]
  # Par exemple, pour les brins :
  #   film.brins[<id du brin>]
  #   ou
  #   film.brins.hash[<id du brin>]
  #
  attr_reader :hash


  # Retourne l'élément d'identifiant +element_id+
  # Par exemple le brin, par `film.brins[12] #=> brin #12`
  def [] element_id
    # Ne pas utiliser la ligne suivante, pour simplifier les
    # test. Sinon, il faudrait toujours créer les éléments.
    # @hash != nil || raise("Aucun élément de type #{self.class.name} n'est défini.")
    @hash != nil || (return nil)
    @hash[element_id]
  end

  # Renvoie le nombre d'éléments.
  # Par exemple `film.brins.count`
  def count
    @hash.nil? ? 0 : @hash.count
  end

  # Permet de faire une boucle sur les éléments en exécutant
  # le code entre crochets.
  # Par exemple :
  #   film.brins.each do |b|
  #     puts b.libelle
  #   end
  def each &block
    (@hash||{}).each { |k, e| yield k, e }
  end
  def collect &block
    @hash != nil || (return [])
    @hash.collect { |k, e| yield k, e }
  end


  # Sauver les données dans le fichier marshal
  #
  # Pour fonctionner, l'instance doit définir :
  #   @marshal_file     Path au fichier marshal
  # Les instances des éléments doivent définir
  #   #hash_data      Hash des données à enregistrer
  def save
    File.open(marshal_file,'wb'){|f| f.write Marshal.dump(data2save)}
  end
  def data2save
    @data2save ||= begin
      if @hash.nil?
        d2s = nil
      else
        d2s = Hash.new
        @hash.each do |k, inst|
          d2s.merge!(k => inst.hash_data)
        end
      end
      {
        created_at: Time.now.to_i,
        film_id:    film.id,
        items:      d2s
      }
    end
  end
end
