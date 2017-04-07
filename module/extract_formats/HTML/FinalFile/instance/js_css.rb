# encoding: UTF-8
#
# Méthodes utiles quand l'option :full_file est true (par
# défaut) et qu'il faut donc produire un fichier HTML
# complet.
#
class Collecte
class Extractor
class FinalFile

  FEUILLES_DE_STYLES = [
    # l'id doit être une clé de
    {id: 'evenemencier',  affixe: 'evenemencier',   title: 'Évènemencier'},
    {id: 'chemindefer',   affixe: 'chemin_de_fer',  title: 'Chemin_de_fer'},
    {id: 'sequencier',    affixe: 'sequencier',     title: 'Séquencier'}
  ]


  # Méthode qui permet de produire le code pour charger une feuille de styles
  # qui se trouve dans le dossier lib/css du dossier analyse.
  # Ce code CSS est "accroché" au document produit.
  def balise_styles affixe_file
    '<style type="text/css">' +
      File.read(css_file)     +
    '</style>'
  end

  def css_file
    @css_file ||= File.join(folder_css, 'all.css')
  end

  # Données javascript a donner au programme d'extraction
  def data_javascript
    liste_feuille_de_styles = FEUILLES_DE_STYLES.collect{|dcss| "'#{dcss[:id]}'"}.join(', ')
    <<-JS
<script type="text/javascript">
const FILM_DUREE_SECONDES = #{film.duree};
const FEUILLES_DE_STYLES  = [#{liste_feuille_de_styles}];
</script>
    JS
  end

  def feuilles_de_styles_alternatives
    FEUILLES_DE_STYLES.collect do |dcss|
      titre   = dcss[:title]
      cssname = dcss[:affixe]
      "<link id=\"analyse_thing_#{dcss[:id]}\" title=\"#{titre}\" href=\"./data/analyse/css/extract/#{cssname}.css\" rel=\"alternate stylesheet\" />"
    end.join("\n")
  end


  def folder_css
    @folder_css ||= File.join(MAIN_FOLDER,'module','extract_formats','HTML','css')
  end

end #/FinalFile
end #/Extractor
end #/Collecte
