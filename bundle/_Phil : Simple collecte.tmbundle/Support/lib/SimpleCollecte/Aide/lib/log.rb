# encoding: UTF-8


class SimpleCollecte
class Aide
class << self

  def log mess
    reflog.puts mess
  end
  def reflog
    @reflog ||= File.open(pathlog,'a')
  end
  def pathlog
    @pathlog ||= File.join(FOLDER_AIDE, 'rebuild.log')
  end

end #/<< self
end #/Aide
end #/SimpleCollecte
