# encoding: UTF-8
=begin
  Instance Snippet
  ------------------
  Pour gérer les snippets simplement
=end
class Snippet
  
  attr_reader :snippet_id
  
  def initialize snippet_id
    @snippet_id = snippet_id
  end
  
  # = main =
  #
  # Méthode principale qui joue le snippet, c'est-à-dire qui 
  # l'écrit en sortie.
  def output
    code != nil || Snippet.alert("Impossible de jouer le snippet.")
    STDOUT.write code
  end
  
  def code
    @code ||= begin
      case snippet_id
      when :inserer_personnage
        "[PERSO#${1|#{Personnage.list_ids.join(',')}|}]$0" rescue nil
      else
        Snippet.alert("Le snippet id `#{snippet_id}` est inconnu.")
        nil
      end
    end
  end
end #/Snippet