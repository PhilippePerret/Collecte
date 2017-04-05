# encoding: UTF-8
class Collecte
class Metadata

  def exist? ; File.exist?(path) end
  
  def path
    @path ||= File.join(collecte.folder, 'metadata.collecte')
  end

end #/Metadata
end #/Collecte
