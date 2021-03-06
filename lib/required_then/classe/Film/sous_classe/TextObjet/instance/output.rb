# encoding: UTF-8
class Film
class TextObjet

  def to_hash
    h = Hash.new
    [
      :raw, :only_str,
      :personnages_ids, :notes_ids, :brins_ids,
      :scene_id, :scenes_ids
    ].each{|prop|h.merge!(prop => self.send(prop))}
    # Autres propriétés
    h.merge!(horloge: (horloge ? horloge.to_hash : nil))
    return h
  end

  # Distpatch dans le texte-objet les données +hdata+ et
  # retourne l'instance Film::TextObjet
  def dispatch hdata
    hdata.nil? || hdata.each{|k,v|instance_variable_set("@#{k}",v)}
    @horloge.nil? || @horloge = Film::Horloge.new(film, @horloge)
    return self # Pour chainer
  end

  # Version String du texte-objet
  #
  # Par rapport au texte original (@raw), les balises
  # personnages ont été remplacées par les pseudos et les
  # marques de brins et de notes ont été supprimées.
  def to_str options = nil
    only_str.to_s
  end


end #/TextObjet
end #/Film
