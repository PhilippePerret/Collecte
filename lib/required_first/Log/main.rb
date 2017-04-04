# encoding: UTF-8
#
# Module pour la méthode `log` qui permet de tenir à
# jour un fichier log.
#

# Méthode principale handy pour écrire un message log de partout
# dans le programme
#
# +options+
#   Si :error est défini, c'est l'erreur rencontrée.
#   Son message sera affichée ainsi que son backtrace enregistré
def log mess, options = nil
  Log.add mess, options
end

class Log
class << self

  def add mess, options = nil
    options ||= Hash.new
    if options.key?(:error) || options.key?(:fatal_error)
      e = options[:error] || options[:fatal_error]
      mess = "### ERREUR #{mess} : #{e.message}#{RC}#{e.backtrace.join(RC)}"
    end
    ref.puts "#{now} #{mess}"
    # Si c'est une erreur fatale qui est envoyée, il faut
    # interrompre la production.
    # Si c'est une erreur non fatale, non poursuit mais en
    # enregistrant l'erreur dans les erreurs de la collecte
    if options.key?(:fatal_error)
      raise options[:fatal_error]
    elsif options.key?(:error)
      Collecte.current.add_error mess
    end
  end

  def now
    Time.now.strftime("%d/%m %H:%M:%S")
  end
  def ref
    @ref ||= begin
      remove
      File.open(path,'a')
    end
  end
  def remove
    exist? || return
    File.unlink(path)
  end
  def exist?
    File.exist? path
  end
  def path
    @path ||= File.join(MAIN_FOLDER, 'process.log')
  end
end #/<< self
end #/ Log
