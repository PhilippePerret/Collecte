# encoding: UTF-8
class Film
class Brins

  include CollecteFileMethods

  def add bloc
    @hash ||= Hash.new
    brin = Film::Brin.new(self.film)
    brin.parse(bloc)
    @hash.merge!( brin.id => brin )
  rescue BadBlocData => e
    log "Mauvaises données pour un bloc de brin", error: e
  end

end #/Brins
end #/Film
