# encoding: UTF-8
class ::Array

  # Sert pour obtenir facilement un array lorsque l'on veut
  # obtenir un array depuis un string, un fixnum, etc. ou un
  # array. Si l'élément est déjà un array, on n'a rien à faire
  # d'autre que de le renvoyer.
  def in_array ; self end

  def to_sym
    self.collect do |e|
      case e
      when Hash, Array then e.to_sym
      else e
      end
    end
  end

  def pretty_inspect
    "[\n" +
    self.collect do |item|
      case item
      when Hash, Array then item.pretty_inspect
      else item.inspect
      end
    end.join("\n") +
    "\n]"
  end

  # Prend la liste {Array}, sépare toutes les valeurs par des virgules sauf
  # les deux dernières séparées par un "et"
  def pretty_join
    self.count > 0 || (return '')
    all = self.dup
    all.count > 1 || (return all.first.to_s)
    last = all.pop.to_s
    all.join(', ') + ' et ' + last
  end

  def nil_if_empty
    self.empty? ? nil : self
  end

end
