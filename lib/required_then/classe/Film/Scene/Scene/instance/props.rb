# encoding: UTF-8
class Film
class Scene

  # ------------------------------------------------------
  # Voir les propriétés héritées des RelativeObjectMethods
  # ------------------------------------------------------

  # {Fixnum} Numéro de la scène
  attr_reader :numero

  # {String} Effet
  attr_reader :effet, :effet_alt

  # {String} Lieu
  attr_reader :lieu, :lieu_alt

  # {String} Décor
  attr_reader :decor, :decor_alt

  # {Film::TextObjet} Résumé de la scène
  attr_reader :resume

  # {Array de Film::TextObjet} Liste des paragraphes
  attr_reader :paragraphes

  # {String} Fonction de la scène
  attr_reader :fonction

  def notes
    @notes ||= Film::Notes.new(self.film)
  end

  # Raccourci
  def duree ; @duree ||= horloge.duree end

  # Méthode qui définit la durée de la scène
  # Rappel : cette donnée est maintenue dans horloge
  def set_duree
    horloge.duree =
      if film.scenes[self.numero+1]
        film.scenes[self.numero+1].time
      else
        film.duree + film.start.time
      end - time
  end

  # === Raccourcis ===
  def time
    @time ||= begin
      horloge.nil? ? nil : horloge.time
    end
  end

end #/Scene
end #/Film
