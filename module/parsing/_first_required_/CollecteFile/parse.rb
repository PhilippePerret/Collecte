# encoding: UTF-8
module CollecteFileMethods

  # = main =
  #
  # Méthode principale qui parse le fichier brins s'il
  # existe et définit le fichier marshal brins.msh associé
  # au film.
  #
  def parse
    collecte_exist? || begin
      log "Pas de fichier #{collecte_file}"
      return
    end
    blocs.each { |bloc| add(bloc) }
  end

  # Tous les blocs du code définissant normalement un élément (i.e.
  # un brin, un personnage, etc.)
  def blocs
    @blocs ||= begin
      # On supprime tous les commentaires
      cf = File.read(collecte_file).strip.split(RC).collect do |line|
        if line.strip.start_with?('#')
          nil
        else
          line
        end
      end.compact.join(RC)
      cf.split(RC*2).collect{|b| b.strip}
    end
  end

end
