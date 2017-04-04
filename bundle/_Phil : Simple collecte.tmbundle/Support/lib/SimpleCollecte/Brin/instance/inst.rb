# encoding: UTF-8
class SimpleCollecte
class Brin
  
  attr_reader :id
  attr_reader :libelle
  
  def initialize data
    data.each{|k,v|instance_variable_set("@#{k}",v)}
  end
  
  
  def for_snippet
    @for_snippet ||= "#{id}-#{libelle}"
  end
  
end #/Brin
end #/SimpleCollecte