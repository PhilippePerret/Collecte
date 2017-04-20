# encoding: UTF-8
class CFile

  def open
    Collecte.mode_test? && return
    `open "#{path}"`
  end

  def save
    content.to_s != '' || return
    # On s'assure que le dossier existe
    folder_exist? || build_folder
    File.open(path,'wb'){|f| f.write content}
  end

  def read
    File.exist?(path) || (return '')
    File.read(path)
  end

  # Construit le dossier (même s'il est dans une longue
  # hiérarchie inexistante)
  def build_folder
    `mkdir -p "#{folder}"`
  end
end
