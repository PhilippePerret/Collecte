# encoding: UTF-8
class SimpleCollecte
class Aide
class << self

  # On reconstruit le fichier d'aide si nécessaire
  def rebuild_aide
    require 'sass'
    require 'kramdown'
    File.unlink(html_file) if File.exist?(html_file)
    File.open(html_file,'wb'){|f| f.write full_html_code}
  end

  # ---------------------------------------------------------------------
  #   Le texte HTML complet et assemblé
  # ---------------------------------------------------------------------
  def full_html_code
    @full_html_code ||= begin
      [
        '<script type="text/javascript">',
          javascript,
        '</script>',
        '<style type="text/css">',
          css_code,
        '</style>',
        '<h1>Analyse de film<br>Manuel de collecte simple</h1>',
        tdm_html,
        texte_aide_html
      ].join(RC)
    end
  end

  # Le texte de l'aide transformé de markdown en HTML
  def texte_aide_html
    @texte_aide_html ||= begin
      Kramdown::Document
          .new(texte_markdown_complet)
          .to_html
    end
  end

  # ---------------------------------------------------------------------
  #   Le texte markdown de l'aide
  # ---------------------------------------------------------------------

  # Le texte markdown complet, avec le texte et les
  # liens référencés.
  def texte_markdown_complet
    @texte_markdown_complet ||= begin
      texte_aide_markdown + RC + links_aide_markdown
    end
  end

  # Le texte du fichier `aide.md`
  def texte_aide_markdown
    @texte_aide_markdown ||= begin
      File.read(markdown_file)
    end
  end
  # Le texte du fichier `aide_links.md`
  def links_aide_markdown
    @links_aide_markdown ||= begin
      File.read(markdown_links_file)
    end
  end

  # ---------------------------------------------------------------------
  #   La table des matières
  # ---------------------------------------------------------------------
  def tdm_html
    @tdm_html ||= begin
      '<nav id="tdm">' + RC +
      tdm.collect do |titre|
        "<a href=\"##{titre[:id]}\"  class=\"level#{titre[:level]}\">#{titre[:titre]}</a>"
      end.join(RC) +
      RC + '</nav>'
    end
  end

  # Les titres de la table des matières, relevés dans le
  # texte markdown
  def tdm
    @tdm ||= begin
      # a = Array.new
      # texte_aide_markdown.scan(/(\#{2,6}) (.*?) \{\#(.*?)\}/){
      #   a << {titre: $2.strip, id: $3.strip, level: $1.length - 1}
      # }
      # a
      texte_aide_markdown.scan(/(\#{2,6}) (.*?) \{\#(.*?)\}/).to_a.collect do |found|
        level, titre, id = found
        {titre: titre.strip, id: id.strip, level: level.length - 1}
      end
    end
  end


  # ---------------------------------------------------------------------
  #   Styles
  # ---------------------------------------------------------------------

  # Le code CSS à ajouter au fichier
  def css_code
    @css_code ||= Sass.compile(sass_code, sass_options)
  end
  # Les options de compilation du code SASS
  def sass_options
    @sass_options ||= {
      line_comments:  false,
      syntax:         :sass,
      style:          :compressed
    }
  end
  # Le code SASS pour les styles
  def sass_code
    @sass_code ||= File.read(sass_file)
  end


  # ---------------------------------------------------------------------
  #   Javascript
  # ---------------------------------------------------------------------

  def javascript
    @javascript ||= begin
      <<-JS
/* Pour ouvrir un lien dans Firefox plutôt que dans TextMate */
function open_url(url) {TextMate.system("open '" + url + "'")}
      JS
    end
  end
end #/<< self
end #/Aide
end #/SimpleCollecte
