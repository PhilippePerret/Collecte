# encoding: UTF-8
class Array
  # Retourne True si le Array passe les conditions
  # définies dans la procédure +procedure+
  def passe_filtre? procedure
    procedure.call(self)
  end
end
class NilClass
  def passe_filtre?(p) ; false end
end

class Collecte
class Extractor

  # Analyse du filtre et transformation des valeurs
  def analyze_filter
    options.key?(:filter) || return
    [:brins, :notes, :personnages].each do |prop|
      options[:filter].key?(prop) || next
      options[:filter][prop] = filter_str_to_proc(options[:filter][prop])
    end
  end

  # Reçoit le filtre string (p.e. '2+45') et retourne
  # le processus qui permettra à la méthode passe_filtre?
  # de renvoyer la bonne valeur
  def filter_str_to_proc filtre
    code_filtre =
      filtre.as_filter_str_to_array.collect do |cond|
        cond.collect{|v| "a.include?(#{v})"}.join(' || ') + ' || raise'
      end.join(RC)
    # Fabrication du processus
    Proc.new { |a|
      begin ; eval(code_filtre)
      rescue ; false
      else ; true
      end
    }
  end
end #/Extractor
end #/Collect
