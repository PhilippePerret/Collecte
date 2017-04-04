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
end #/String
