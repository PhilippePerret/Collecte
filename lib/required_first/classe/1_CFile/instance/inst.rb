# encoding: UTF-8
class CFile

  # +owner+ Propriétaire du fichier, quelconque
  # +path+  Path au fichier, optionnel. Mais attention, s'il n'est
  #         pas défini, il faudra le définir rapidement avant
  #         son utilisation, par `CFile#path=`
  def initialize owner, path = nil
    @owner  = owner
    @path   = path
  end

end
