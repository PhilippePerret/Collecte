require_relative 'direct'
require_relative 'Objet'
# Utilitaires pour procédés
class Procede
  
  class << self

    # => Return le prochain ID pour un procédé
    def next_id
      Objet::next_id_of_type 'PROCEDE'
    end

    # Note : cette méthode a besoin de connaitre l'emplacement du programme principal
    # pour trouver les catégories
    def snippet_categories
      # On prend la liste des catégories
      require path_module_categories
      
      c = "PROCEDE##{next_id}: CATE:${1|"
      c << PROCEDES_PER_CATEGORIES.collect{ |k_cate, data_cate| k_cate }.join(',')
      c << "|} PROC:$0[TAB => liste procédés de la catégorie]"
    end
    
    # Note : cette méthode a besoin de connaitre l'emplacement du programme principal
    # pour trouver les catégories
    def snippet_procede_of_categorie
      line = Snippet::input
      # On doit trouver la catégorie
      found = line.match(/^(.*)CATE:([a-zA-Z_]+) /).to_a
      cate = found[2].to_sym
      c = found[1]
      c << "CATE:#{cate} PROC:"
      # On prend la liste des procédés de cette catégorie
      c << "${1|"
      c << data_categories[cate][:procedes].collect{|k,v| k}.join(',')
      c << "|} $0" 
      # On renvoie le snippet
      c
    end
    
    def data_categories
      @data_categories ||= begin
        require path_module_categories
        PROCEDES_PER_CATEGORIES
      end
    end
    
    # Affiche la liste des procédés et leur description dans une fenêtre d'aide
    def help
      help_css + 
      "<h1>Aide sur les catégories de procédés</h1>"+
      data_categories.collect do |cate, data_cate|
        "<div class='categorie'>#{cate.capitalize}</div>" +
        "<div>" + data_cate[:procedes].collect do |proc_id, proc_data|
          c = "<div class='procede'>#{proc_id.inspect}</div>"
          c << "<div class='description'>#{proc_data[:description]}</div>" if proc_data[:description]
          c
        end.join('') + "</div>"
      end.join('')
    end
    
    # => Retourne le code pour la feuille css de l'aide
    def help_css
      <<-HTML
<style type="text/css">
.categorie {
  font-size:2em;
  font-weight:bold
}
.categorie + div {
  margin-left:1.7em;
}
.procede {
  font-size:1.4em;
  color:blue;
}
.description {
  margin-left:2em;
  font-size:1.2em
}
</style>
      HTML
    end
    
    def path_module_categories
      @path_module_categories ||= File.join(FilmTM::folder_data, 'procedes_categories.rb')
    end
  end # << self Objet
  
end