# encoding: UTF-8

def div content, attrs = nil
  "#{opened_tag 'div', attrs}#{content}</div>"
end

def span content, attrs = nil
  "#{opened_tag 'span', attrs}#{content}</span>"
end

def link content, attrs = nil
  "#{opened_tag 'a', attrs}#{content}</a>"
end

def libval label, value, div_attrs = nil
  div_attrs ||= Hash.new
  div_attrs.key?(:class) || div_attrs.merge!(class: 'libval')
  div(
    span(label, class: 'label')+
    span(value, class: 'value'),
    div_attrs
  )
end

def libval1val2 label, value1, value2, attrs = nil
  attrs ||= Hash.new
  attrs.key?(:class) || attrs.merge!(class: 'libvalval')
  div(
    span(label, class: 'label')+
    span(value1, class: 'value1')+
    span(value2, class: 'value2'),
    attrs
  )
end
alias :libvalval :libval1val2


# Retourne un code type pour une boite de fermeture
# de petite fenetre
def closebox js_method, attrs = nil
  attrs ||= Hash.new
  attrs.merge!({href: '#', onclick: js_method, class: 'closebox'})
  link('x', attrs)
end
# ---------------------------------------------------------------------
#   Méthodes fonctionnelles
# ---------------------------------------------------------------------

# Construction le code HTML de la balise d'ouverture de tabname +tag+ et
# d'attributs optionnels +attrs+
# NOTE: Toutes les valeurs nil sont retirées
def opened_tag tag, attrs = nil
  attrs ||= Hash.new
  # La propriété :displayed indique si l'élément doit être
  # affiché ou non.
  #  La propriété :mask fait le contraire
  #  La propriété :visible indique si l'élément est visible
  displayed       = attrs.delete(:displayed)
  nodisplay       = attrs.delete(:mask)
  has_key_visible = attrs.has_key?(:visible)
  isvisible       = attrs.delete(:visible)

  # Les balises pour Schema.org
  # Noter que `itemscope` n'est plus utilie puisqu'il est
  # ajouté chaque fois que itemtype est défini.
  if attrs.key?(:itemtype) # Schema.org
    itemscope = true
    itemtype  = "http://schema.org/#{attrs[:itemtype]}"
    attrs[:itemtype] = itemtype
  else
    # Item scope peut être employé sans itemtype, par exemple
    # pour une liste d'employés.
    itemscope = attrs.delete(:itemscope)
  end

  # Le style peut être fourni par un string ou un Hash
  if attrs[:style].class == Hash
    attrs[:style] = attrs[:style].collect do |prop, value|
      "#{prop}:#{value};"
    end.join('')
  end

  if nodisplay || displayed === false || attrs.has_key?(:display)
    display = case attrs.delete(:display)
    when nil    then "none" # avec nodisplay et displayed=false
    when false  then "none"
    when true   then "block"
    else display
    end
    attrs[:style] ||= ""
    attrs[:style] += "display:#{display};#{attrs[:style]}"
  end

  if has_key_visible
    attrs[:style] ||= ""
    attrs[:style] += "visibility:#{isvisible ? 'visible' : 'hidden'}"
  end

  attrs =
    unless attrs.empty?
      " " + attrs.reject{|k,v| v.nil?}.collect do |k,v|
        "#{k}=\"#{v}\""
      end.join(' ')
    else
      ""
    end
  attrs += ' itemscope' if itemscope
  "<#{tag}#{attrs}>"
end
