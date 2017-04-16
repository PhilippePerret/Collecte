module ListElementsMethods

  # Ajoute une instance de l'objet singulier à
  # l'instance pluriel. Par exemple une Film::Scene à
  # film.scenes.
  #
  # La méthode est aussi bien utilisée lors du parsing des
  # fichiers de collecte que lors de la récupération des
  # données depuis les fichiers marshal ou les fichier
  # pstore.
  #
  def << instance
    @hash ||= Hash.new
    @hash.merge!( instance.id => instance )
  end

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

  # Retourne le premier élément de la liste ou nil
  def first
    (@hash||{}).values.first
  end
  # Retourne le dernier élément de la liste ou nil
  def last
    (@hash||{}).values.last
  end

  # Sauver les données dans le fichier marshal
  #
  # Pour fonctionner, l'instance doit définir :
  #   @marshal_file     Path au fichier marshal
  # Les instances des éléments doivent définir
  #   #to_hash      Hash des données à enregistrer
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
          d2s.merge!(k => inst.to_hash)
        end
      end

      # # DEBUG
      # if self.class.name.to_s == 'Film::Scenes'
      #   log "Nombre de scènes sauvées : #{d2s.count}"
      #   log "            dans le film : #{film.scenes.count}"
      # end
      # # /DEBUG

      {
        created_at: Time.now.to_i,
        film_id:    film.id,
        items:      d2s
      }
    end
  end
end
