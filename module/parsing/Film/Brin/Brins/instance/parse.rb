# encoding: UTF-8
class Film
class Brins

  include CollecteFileMethods

  # +bloc+ est une instance Bloc qui répond à
  # `@code` (le code string des lignes) et `@line`, la
  # ligne où l'élément a été défini.
  def add bloc
    @hash ||= Hash.new
    item = Film::Brin.new(self.film)
    item.parse(bloc.code)
    item.line = bloc.line
    @hash.merge!( item.id => item )
  rescue BadBlocData => e
    log "Mauvaises données pour un bloc de brin", error: e
  end

end #/Brins
end #/Film
