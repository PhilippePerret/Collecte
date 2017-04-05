# encoding: UTF-8

# Fichier de métadonnées à placer dans le dossier
# +dossier+
def make_file_meta dossier, code
  p = File.join(dossier, 'metadata.collecte')
  File.open(p,'wb'){|f| f.write code}
end
def remove_file_meta dossier
  p = File.join(dossier, 'metadata.collecte')
  File.exist?(p) || return
  File.unlink(p)
end
