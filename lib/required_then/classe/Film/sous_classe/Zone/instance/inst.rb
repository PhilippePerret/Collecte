# encoding: UTF-8
#
# Classe Film::Zone
#
# Pour une zone de temps
class Film
class Zone

  def initialize hdata
    @data = hdata
    hdata && hdata.each{|k,v|instance_variable_set("@#{k}",v)}
    calcule_temps
  end

end #/Zone
end #/Film
