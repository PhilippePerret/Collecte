# encoding: UTF-8
class Film
class TextObjet

  def to_html
    c = only_str.dup
    c.gsub!(/\[PERSO\#(.*?)\]/) { |pid|
      film.personnages[pid].pseudo
    }

    return c
  end

end #/TextObjet
end #/Film
