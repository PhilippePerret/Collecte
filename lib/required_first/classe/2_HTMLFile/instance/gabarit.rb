# encoding: UTF-8
#
# Ce module contient en même temps toutes les méthodes qui
# permettent de gérer le gabarit, appelées par le bind, et
# les méthodes pour traiter le gabarit.
#
class HTMLFile < CFile

  # = main =
  #
  # Tous les éléments du code HTML ont été définis (css,
  # js, body, etc.) on peut construire le code final du
  # fichier et le sauver.
  #
  def build_and_save
    build_content
    save
  end
  # = main =
  #
  # Met le code du fichier dans @full_code
  def build_content
    require 'erb'
    @content = ERB.new(gabarit_code).result(self.bind)
  end

  def gabarit_code
    @gabarit_code ||= File.read(_('gabarit.erb', __FILE__))
  end

  def bind ; binding() end

  # ---------------------------------------------------------------------
  #   Méthodes utiles au gabarit
  # ---------------------------------------------------------------------

  def title ; @title ||= 'Fichier sans titre' end
  def title= value ; @title = value end

  # Pour pouvoir utiliser `html_file.css << "<du code css>"`
  def css
    @css ||= String.new
  end
  # Pour pouvoir utiliser `html_file.js << "<code js>"` pour
  # ajouter du code javascript. Le contenu d'un fichier par
  # exemple.
  def js
    @js ||= String.new
  end

  def css_code
    @css_code ||= css || ''
  end

  def javascript_code
    @javascript_code ||= ''
  end

  def logo ; @logo ||= '' end
  def logo= value ; @logo = value end

  def body ; @body ||= '' end
  def body= value ; @body = value end
end
