# encoding: UTF-8
class HTMLFile < CFile

  # +owner+ Propriétaire du fichier, quelconque
  def initialize owner, path = nil
    super(owner, path)
  end

end
