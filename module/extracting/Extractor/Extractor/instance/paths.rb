# encoding: UTF-8
class Collecte
class Extractor

  def folder_css
    @folder_css ||= File.join(MAIN_FOLDER,'module','extract_formats','HTML','css')
  end

  def folder_js
    @folder_js ||= File.join(MAIN_FOLDER,'module','extract_formats','HTML','js')
  end

end #/Extractor
end #/Collect
