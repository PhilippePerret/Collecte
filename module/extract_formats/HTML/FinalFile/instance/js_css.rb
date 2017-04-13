# encoding: UTF-8
#
# Méthodes utiles quand l'option :full_file est true (par
# défaut) et qu'il faut donc produire un fichier HTML
# complet.
#
class Collecte
class Extractor
class FinalFile

  def whole_javascript_code
    javascript_files || (return '')
    '<script type="text/javascript">' +
    javascript_files.collect do |js_path|
      File.read(js_path)
        .gsub(/\/\*(.*?)\*\//,'') # commentaires /* ... */
        .gsub(/\/\/(.*?)$/,'')    # commentaires // ...
        .gsub(/#{RC}/,'')
    end.join(RC) +
    '</script>'
  end

  def whole_css_code
    cssise_all_sass
    css_files || (return '')
    '<style type="text/css">' +
      css_files.collect{|css|File.read(css)}.join(RC) +
    '</style>'
  end
  def cssise_all_sass
    require 'sass'
    # On relève la date de tous les fichiers CSS
    data_css = Hash.new
    # Pour mettre le temps le plus vieux d'un fichier
    # CSS. Il suffit qu'il soit plus vieux qu'un fichier commençant
    # par '_' et on actualise tous les fichiers.
    older_time = Float::INFINITY
    csss = Dir["#{collecte.extractor.folder_css}/**/*.css"].each do |css_path|
      mtime = File.stat(css_path).mtime.to_i
      data_css.merge!(css_path => mtime)
      mtime > older_time || older_time = mtime
    end
    # Si un fichier commençant par '_' est trouvé plus vieux
    # que tous les autres fichiers css, l'actualisation générale
    # est nécessaire.
    updateall_required = false
    Dir["#{collecte.extractor.folder_css}/**/_*.sass"].each do |sass_path|
      File.stat(sass_path).mtime.to_i < older_time || begin
        log "Le fichier SASS `#{File.basename sass_path}` est plus jeune qu'un des fichiers CSS => actualisation générale nécessaire."
        updateall_required = true
        break
      end
    end
    Dir["#{collecte.extractor.folder_css}/**/*.sass"].each do |sass_path|
      affixe   = File.basename(sass_path, File.extname(sass_path))
      # On passe les fichier inclus
      affixe.start_with?('_') && next
      css_name = affixe + '.css'
      css_path = File.join(File.dirname(sass_path), css_name)
      updateall_required || outofdate(sass_path, css_path) || next
      log "SASSisation du fichier CSS `#{css_name}`"
      Sass.compile_file(sass_path, css_path, sass_options)
    end
  end
  # Un fichier est out-of-date si le fichier source est
  # plus récent que le fichier destination ou si le fichier
  # destination n'existe pas
  def outofdate src, dst
    File.exist?(dst) || (return true)
    return File.stat(src).mtime > File.stat(dst).mtime
  end

  # Options de transformation SASS->CSS
  def sass_options
    @sass_options ||= {
      line_comments:  false,
      # syntax:         :sass,
      style:          :compressed
    }
  end

#   FEUILLES_DE_STYLES = [
#     # l'id doit être une clé de
#     {id: 'evenemencier',  affixe: 'evenemencier',   title: 'Évènemencier'},
#     {id: 'chemindefer',   affixe: 'chemin_de_fer',  title: 'Chemin_de_fer'},
#     {id: 'sequencier',    affixe: 'sequencier',     title: 'Séquencier'}
#   ]
#
#   # Données javascript a donner au programme d'extraction
#   def data_javascript
#     liste_feuille_de_styles = FEUILLES_DE_STYLES.collect{|dcss| "'#{dcss[:id]}'"}.join(', ')
#     <<-JS
# <script type="text/javascript">
# const FILM_DUREE_SECONDES = #{film.duree};
# const FEUILLES_DE_STYLES  = [#{liste_feuille_de_styles}];
# </script>
#     JS
#   end
#
#   def feuilles_de_styles_alternatives
#     FEUILLES_DE_STYLES.collect do |dcss|
#       titre   = dcss[:title]
#       cssname = dcss[:affixe]
#       "<link id=\"analyse_thing_#{dcss[:id]}\" title=\"#{titre}\" href=\"./data/analyse/css/extract/#{cssname}.css\" rel=\"alternate stylesheet\" />"
#     end.join("\n")
#   end

end #/FinalFile
end #/Extractor
end #/Collecte
