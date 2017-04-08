# encoding: UTF-8
class Collecte

  def confirmation_parsing

  end

  # Copie le fichier journal process.log dans le
  # dossier de la collecte
  def copie_process_log
    src = File.join('.', 'process.log')
    dst = File.join(folder, 'process.log')
    FileUtils.cp src, dst
  end
end
