# encoding: UTF-8
=begin
  Classe principale d'un objet relatif
=end
module RelativeObjectMethods

  # {Film} Instance du film auquel appartient l'objet
  # Donc, par exemple, le film de la note ou de la scène
  attr_reader :film

  # {String|Fixnum} ID de l'objet relatif. Ça peut être un entier
  # (scène, note, brin) ou un string (personnage)
  attr_accessor :id

  # {Fixnum} Ligne où la scène est définie dans le fichier
  # (pour pouvoir y aller depuis les fichiers HTML)
  attr_accessor :line

  # {String} Le libellé de l'objet relatif, qui peut être son
  # résumé (scène), son contenu (note) ou son titre (brin)
  attr_accessor :libelle

  # {Fixnum} Identifiant de la scène à laquelle appartient
  # l'objet relatif
  attr_reader :scene_id

  # {Array de Fixnum} Liste des Identifiants de scènes
  # auxquelles appartient l'objet
  attr_reader :scenes_ids

  # {Film::Horloge} Horloge de l'objet. Permet de
  # le « temporiser ».
  # Noter que cette classe complexe permet aussi de gérer
  # les durées.
  attr_reader :horloge

  # {String} Description
  # Note : utilisée seulement pour quelques objets comme
  # les brins
  attr_reader :description

  # {Array de Fixnum} Liste des identifiants de brins
  # auxquels l'objet appartient
  attr_reader :brins_ids
  # {Array de String} Liste des identifiants de personnages
  # que contient l'objet
  attr_reader :personnages_ids

  # {Array de Fixnum} Liste des identifiants de notes
  # auquel l'objet appartient
  # Note : une note est aussi un Objet Relatif.
  attr_reader :notes_ids

  # Propriétés volatiles
  # --------------------

  # Renvoie le type de l'élémen par exemple :brin,
  # :personnage ou :scene
  def type_element
    @type_element ||= self.class.name.to_s.split('::').last.downcase.to_sym
  end

  def scenes
    @scenes ||= begin
      a = Array.new
      # TODO à définir
      a
    end
  end
end #/ RelativeObject
