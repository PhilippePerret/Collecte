# encoding: UTF-8
class String

  # Transforme l'horloge en nombre de secondes
  def h2s
    scs, mns, hrs = self.split(':').reverse
    hrs.to_i * 3600 + mns.to_i * 60 + scs.to_i
  end

  def nil_if_empty
    if self.strip == ''
      nil
    else
      self.strip
    end
  end

  # Quand self est de la forme '2+(4,5)', retourne
  # un array contenant [[2],[4,5]] pour un filtrage, en
  # sachant que chaque élément de l'array principal doit
  # retourner vrai et les sous-arrays doivent être
  # alternatif non exclusifs (l'élément doit appartenir à 2
  # ET appartenir à 4 OU 5)
  def as_filter_str_to_array
    self.split('+').collect do |item|
      item = item.strip
      if item.start_with?('(') && item.end_with?(')')
        item[1..-2].split(',').collect{|i|i.strip.to_i}
      elsif item.match(/,/)
        item.split(',').collect{|i|i.strip.to_i}
      else
        [item.strip.to_i]
      end
    end
  end

end #/String
