# encoding: UTF-8
class Collecte

  def initialize path = nil
    @folder = path
    self.class.current= self
    path.nil? || log('INSTANCIATION COLLECTE '+File.expand_path(folder).inspect)
  end

end #/Collect
