# encoding: UTF-8
class Film
class RelationsPersonnages

  # Définition des relations entre les personnages.
  #
  # Cette méthode est appelée :
  #   - au chargement des données du film
  #   - à la fin du parse du fichier personnages
  #
  # Elle passe en revue toutes les scènes en mettant dedans
  # tous les personnages qui sont en relation. Si un personnage
  # est en relation avec un autre dans au moins deux scènes,
  # ils sont en relations.
  #
  # La méthode permet aussi de définir la propriété
  # `@relations` de Film::Personnage
  #
  def define
    log "-> Film::RelationsPersonnages::define"
    # Film::Personnage#in_relation_with
    film.scenes.each do |sid, scene|
      scene.personnages_ids || next
      scene.personnages.each do |perso|
        perso.relations != nil || perso.relations = Hash.new
        # On prend la liste des autres personnages et
        # on créer la relation
        pids_sans_lui = scene.personnages_ids.dup
        pids_sans_lui.delete(perso.id)
        pids_sans_lui.each do |pid|
          if false == perso.relations.key?(pid)
            perso.relations.merge!(pid => Array.new)
          end
          perso.relations[pid] << scene.id
        end
      end
    end

    # Les relations sont définies pour chaque personnage, on
    # va maintenant ne prendre que celles qui se font sur
    # au moins deux scènes pour considérer que c'est une
    # relation
    film.personnages.each do |perso_id, perso|
      perso.relations || next
      perso.relations.each do |prid, scenes_ids|
        # scenes_ids est une liste des ID de scène
        scenes_ids.count > 1 || next
        # Construire l'identifiant de cette relation
        rel_id = [perso_id, prid].sort_by{|n| n}.join('_')
        # Si les deux personnages sont déjà en relation, il est
        # inutile de créer la relation.
        film.relations_personnages[rel_id].nil? || next
        log "   Création de la relation entre #{perso.pseudo} (##{perso_id}) et #{film.personnages[prid].pseudo} (##{prid}) (relation ##{rel_id})"
        irelation = Film::RelationPersonnage.new(film, rel_id, [perso_id, prid])
        irelation.scenes_ids = scenes_ids
        self << irelation
      end
    end
    log "   NOMBRE RELATIONS CRÉÉES : #{film.relations_personnages.count}"
    log "<- Film::RelationsPersonnages::define"
  end
  # /define

end #/
end #/Film
