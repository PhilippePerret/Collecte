# encoding: UTF-8
class Fixnum

  # Transforme le nombre de secondes en horloge
  def s2h
    s = self.to_i
    hrs = s / 3600
    mns = s % 3600
    scs = (mns % 60).to_s.rjust(2,'0')
    mns = (mns / 60).to_s.rjust(2,'0')
    "#{hrs}:#{mns}:#{scs}"
  end

end
