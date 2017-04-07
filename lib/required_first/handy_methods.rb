

# Méthode permettant d'obtenir facilement le path d'un
# fichier se trouvant dans la hiérarchie propre du fichier
# utilisant la méthode
# +base+ doit être toujours mis à __FILE__ donc la syntaxe
#         de base est `path = _('monfichier.erb', __FILE__)`
#
def _(relpath, base)
  return File.join(File.dirname(File.expand_path(base)), relpath)
end
