# encoding: UTF-8
class Film
class Notes

  include CollecteFileMethods

  def add bloc
    if bloc.respond_to?(:line)
      bloc_code = bloc.code
      line      = bloc.line
    else
      bloc_code = bloc
      line      = nil
    end
    @hash ||= Hash.new
    item = Film::Note.new(self.film)
    item.parse(bloc_code)
    item.line = line
    @hash.merge!( item.id => item )
  rescue BadBlocData => e
    log "Mauvaises données pour un bloc de brin", error: e
  end

end #/Notes
end #/Film
