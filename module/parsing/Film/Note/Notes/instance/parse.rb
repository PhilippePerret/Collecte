# encoding: UTF-8
class Film
class Notes

  include CollecteFileMethods

  def add bloc
    @hash ||= Hash.new
    item = Film::Note.new(self.film)
    item.parse(bloc)
    @hash.merge!( item.id => item )
  rescue BadBlocData => e
    log "Mauvaises données pour un bloc de brin", error: e
  end

end #/Notes
end #/Film
