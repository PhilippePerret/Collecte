# encoding: UTF-8
class Film

  def pourcentage_duree_for secondes, nombre_decimales = nil
    nombre_decimales ||= 1
    (100.0 / (self.duree.to_f / secondes)).round(nombre_decimales).to_s + '%'
  end

end #/Film
