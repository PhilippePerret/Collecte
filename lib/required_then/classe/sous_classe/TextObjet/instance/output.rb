# encoding: UTF-8
class Film
class TextObjet

  def hash_data
    h = Hash.new
    [
      :raw, :to_str,
      :personnages_ids, :notes_ids, :brins_ids,
      :scene_id, :scenes_ids
    ].each{|prop|h.merge!(prop => self.send(prop))}
    # Autres propriétés
    h.merge!(horloge: (horloge ? horloge.horloge : nil))
    return h
  end

  # Distpatch dans le texte-objet les données +hdata+ et
  # retourne l'instance Film::TextObjet
  def dispatch hdata
    hdata.each{|k,v|instance_variable_set("@#{k}",v)}
    @horloge.nil? || @horloge = Film::Horloge.new(film, @horloge)
    return self # Pour chainer
  end

  # Version String du texte-objet
  #
  # Par rapport au texte original (@raw), les balises
  # personnages ont été remplacées par les pseudos et les
  # marques de brins et de notes ont été supprimées.
  def to_str options = nil
    @only_str
  end


end #/TextObjet
end #/Film
