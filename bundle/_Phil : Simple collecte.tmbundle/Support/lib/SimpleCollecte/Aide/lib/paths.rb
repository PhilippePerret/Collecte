# encoding: UTF-8
class SimpleCollecte
class Aide
class << self

  def sass_file
    @sass_file ||= File.join(FOLDER_AIDE, 'aide.sass')
  end
  def html_file
    @html_file ||= File.join(FOLDER_AIDE, 'aide.html')
  end
  def markdown_file
    @markdown_file ||= File.join(FOLDER_AIDE, 'aide.md')
  end
  def markdown_links_file
    @markdown_links_file ||= File.join(FOLDER_AIDE, 'aide_links.md')
  end

end #/<< self
end #/Aide
end #/SimpleCollecte
