# encoding: UTF-8
#
# Méthodes utiles quand l'option :full_file est true (par
# défaut) et qu'il faut donc produire un fichier HTML
# complet.
#
class Collecte
class Extractor
class FinalFile


  def whole_css_code
    cssise_all_sass
    '<style type="text/css">' +
      Dir["#{folder_css}/**/*.css"].collect do |css|
        File.read(css)
      end.join(RC) +
    '</style>'
  end
  def cssise_all_sass
    require 'sass'
    Dir["#{folder_css}/**/*.sass"].each do |sass|
      code_css = Sass.compile(File.read(sass), sass_options)
      css_name = File.basename(sass, File.extname(sass)) + '.css'
      css_path = File.join(File.dirname(sass), css_name)
      File.open(css_path,'wb'){|f| f.write code_css}
    end
  end
  # Options de transformation SASS->CSS
  def sass_options
    @sass_options ||= {
      line_comments:  false,
      syntax:         :sass,
      style:          :compressed
    }
  end

  FEUILLES_DE_STYLES = [
    # l'id doit être une clé de
    {id: 'evenemencier',  affixe: 'evenemencier',   title: 'Évènemencier'},
    {id: 'chemindefer',   affixe: 'chemin_de_fer',  title: 'Chemin_de_fer'},
    {id: 'sequencier',    affixe: 'sequencier',     title: 'Séquencier'}
  ]

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
