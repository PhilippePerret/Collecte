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

  # Version String du texte-objet
  #
  # Par rapport au texte original (@raw), les balises
  # personnages ont été remplacées par les pseudos et les
  # marques de brins et de notes ont été supprimées.
  def to_str options = nil
    @only_str
  end

  # Version HTML du texte-objet
  def to_html options = nil

  end


end #/TextObjet
end #/Film
