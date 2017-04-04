# encoding: UTF-8
class SimpleCollecte
class Aide
class << self

  def print
    up_to_date? || rebuild_aide
    STDOUT.write File.read(html_file)
  end

  # Retourne true si le fichier HTML d'aide (qui sera chargé
  # comme manuel) doit être actualisé
  def up_to_date?
    # Le fichier HTML final doit exister
    File.exist?(html_file) || begin
      log "- Le fichier HTML n'existe pas, il faut le construire."
      return false
    end
    # Tous les fichiers constituant le fichier final doivent
    # être plus vieux que le fichier final
    age_fichier_final = File.stat(html_file).ctime
    [
      sass_file,
      markdown_links_file,
      markdown_file
    ].each do |f|
      File.stat(f).ctime < age_fichier_final || begin
        log "- Le fichier #{f} est plus jeune que le fichier HTML => Il faut reconstruire l'aide."
        return false
      end
    end
    # Tout est OK
    return true
  end
end #/<< self
end #/Aide
end #/SimpleCollecte
