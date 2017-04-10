# encoding: UTF-8
class Log
class << self

  # Si les options d'extraction ou de parse contiennent
  # l'option :show_errors ou :show_process, on sort un
  # fichier HTML de l'opération qui vient d'être produite
  def build_and_open_html_file
    build
    html_file.open
  end

  # Construction du fichier HTML
  def build
    ref.close

    # Titre du fichier
    html_file.title = "Log du #{date_str}"
    html_file.logo  = "<h2>Log du #{date_str}</h2>"

    # CSS
    html_file.css << "div.error{color:red}"

    # On va récupérer toutes les lignes d'erreur pour
    # les mettre en haut du fichier
    erreurs_lines = Array.new
    File.open(path).each do |line|
      if line.match(/### ERREUR/)
        erreurs_lines << div(line, {class: 'error'})
      end
    end
    erreurs_lines =
      if erreurs_lines.count > 0
        '<h3>Erreurs survenues</h3>'  +
        erreurs_lines.join(RC) + RC   +
        '<h3>Journal complet</h3>'+RC
      else
        ''
      end

    # On définit le contenu du fichier HTML
    html_file.body =
      erreurs_lines +
      '<pre>'+RC+
        File.read(path) + RC +
      '</pre>'

    # On sauve le fichier
    html_file.build_and_save
  rescue
  ensure
    @ref = nil # pour rouvrir le stream
  end

  def date_str
    @date_str ||= Time.now.strftime("%d %m %Y - %H:%M")
  end

  def html_file
    @html_file ||= begin
      Collecte.require_module 'html_methods'
      HTMLFile.new(self, html_file_path)
    end
  end

  def html_file_path
    @html_file_path ||= File.join(Collecte.current.folder, 'log.html')
  end

end #/<< self
end #/Log
