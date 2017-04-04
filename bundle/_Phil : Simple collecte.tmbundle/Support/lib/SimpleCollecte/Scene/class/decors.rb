# encoding: UTF-8
class SimpleCollecte
class Scene
class << self
  
  # Retourne la liste des décors relevés dans le texte
  # de la collecte sous forme de liste de snippet, c'est-à-dire
  # tous les décors séparés par des virgules et entourés par
  # des traits droits.
  # +tab_index+ L'index de tabulation du snippet
  def decors_as_snippet tab_index = 1
    if decors.empty?
      "${#{tab_index}:DÉCOR}"
    else
      "${#{tab_index}|#{decors.join(',')}|}"
    end
  end
  # Retourne la liste des décors relevés dans le texte
  # de la collecte
  def decors
    @decors ||= begin
      TEXTE_COLLECTE.scan(/ (?:JOUR|NUIT|MATIN|SOIR) (.*?)$/).to_a.collect do |found|
        found[0].strip
      end.uniq
    end
  end
  
end #/<< self
end #/Scene
end #/SimpleCollecte