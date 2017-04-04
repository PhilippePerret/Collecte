# encoding: UTF-8
=begin
  Classe principale d'un objet relatif
=end
module RelativeObjectMethods

  # {String|Fixnum} ID de l'objet relatif. Ça peut être un entier
  # (scène, note, brin) ou un string (personnage)
  attr_accessor :id

  # {String} Le libellé de l'objet relatif, qui peut être son
  # résumé (scène), son contenu (note) ou son titre (brin)
  attr_accessor :libelle

  # ID de la scène à laquelle appartient l'objet relatif
  attr_accessor :scene_id

  # {Fixnum} Le temps de cet objet relatif. Correspond à sa
  # scène si c'est une note ou autre
  def time
    @time ||= begin
      if self.respond_to?(:scene)
        scene.time
      elsif horloge
        h2s horloge
      else
        nil
      end
    end
  end

  def horloge
    @horloge ||= begin
      if self.respond_to? :scene
        scene.horloge
      else
        nil
      end
    end
  end

  def scenes_ids
    nil
  end

  # Propriétés relatives
  # --------------------

  def scenes
    @scenes ||= begin
      a = Array.new
      # TODO à définir
      a
    end
  end
end #/ RelativeObject
