# encoding: UTF-8
=begin
  Classe principale d'un objet relatif
=end
module RelativeObjectMethods

  # Dispatch le tableau de données +hash+ dans l'instance
  # Cette méthode est utilisée pour récupérer toutes les
  # données enregistrées dans les fichiers marshal et les
  # remettre dans les instances.
  def dispatch hash
    hash.each{|k,v|instance_variable_set("@#{k}", v)}
  end
  
end #/ RelativeObject
