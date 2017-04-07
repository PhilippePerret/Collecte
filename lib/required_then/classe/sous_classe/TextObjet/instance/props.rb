# encoding: UTF-8
class Film
class TextObjet

  # {Film} Instance du film
  attr_reader :film

  # {String} Texte initial de la ligne.
  attr_reader :raw

  # {String} Seulement le texte (sans les marques
  # de relatifs à la fin)
  attr_reader :only_str

  # {Film::Horloge} Horloge éventuelle du texte-objet
  attr_reader :horloge

  # {Fixnum} Identifiant de la scène auquel appartient le
  # texte-objet
  attr_accessor :scene_id

  # {Array de Fixnum}
  attr_reader :scenes_ids

  # {Array de String}
  attr_reader :personnages_ids

  # {Array de Fixnum}
  attr_reader :brins_ids

  # {Array de Fixnum}
  attr_reader :notes_ids


  # ---------------------------------------------------------------------
  #   Propriétés volatiles
  # ---------------------------------------------------------------------

  def scene
    @scene ||= film.scenes[@scene_id]
  end

  def scenes
    @scenes ||= (scenes_ids||[]).collect { |sid| film.scenes[sid] }
  end

  def personnages
    @personnages ||= (personnages_ids||[]).collect{ |pid| film.personnages[pid] }
  end

  def brins
    @brins ||= (brins_ids||[]).collect{ |bid| film.brins[bid] }
  end

  def notes
    @notes ||= (notes_ids||[]).collect{ |nid| film.notes[nid] }
  end

end #/TextObjet
end #/Film
