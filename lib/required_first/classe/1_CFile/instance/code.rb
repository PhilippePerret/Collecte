# encoding: UTF-8
class CFile

  # Le code complet du fichier, à enregistrer ou construit
  def content
    @content ||= String.new
  end
  def content= value ; @content = value end

end
