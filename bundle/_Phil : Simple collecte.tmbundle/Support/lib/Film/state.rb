# encoding: UTF-8
class Film
class << self
  def collecte_simple?
    defined?(@is_collecte_simple) || begin
      @is_collecte_simple = !code_collecte.match(/^SCENE:/)
    end
    @is_collecte_simple
  end
end #/<< self
end #/ Film