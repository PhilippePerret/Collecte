# encoding: UTF-8
class Film

  def scenes      ; @scenes       ||= Scenes.new(self)      end
  def brins       ; @brins        ||= Brins.new(self)       end
  def personnages ; @personnages  ||= Personnages.new(self) end
  def notes       ; @notes        ||= Notes.new(self)       end
  def decors      ; @decors       ||= Decors.new(self)      end
  def relations_personnages
    @relations_personnages ||= RelationsPersonnages.new(self)
  end
end #/Film
