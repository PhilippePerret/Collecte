describe 'Extraction avec options pour l’intitulé' do
  #
  # On joue sur les options[:no_<element>] pour les
  # faire apparaitre ou non.
  # Par exemple options[:no_numero] pour supprimer le
  # numéro.
  # Les paramètres sont :
  # :horloge, :numero, :lieu, :decor, :effet
  #
  let(:collecte) { @collecte }
  let(:code) { @code }
  let(:nombre_scenes){@nombre_de_scenes}

  # Sans horloge
  context 'sans horloge' do
    before(:all) do
      extract_sequencier(no_horloge: true)
    end
    it 'n’affiche pas l’horloge' do
      (1..nombre_scenes).each do |num|
        expect(code).to have_tag("div#scene-#{num}") do
          with_tag('span.numero', text: num)
          without_tag('span.horloge')
          with_tag('span.effet')
          with_tag('span.lieu')
          with_tag('span.decor')
        end
      end
    end
  end
  # Sans numéro
  context 'sans numéro' do
    before(:all) do
      extract_sequencier(no_numero: true)
    end
    it 'contient le bon nombre de scènes' do
      expect(nombre_scenes).to eq 4
    end
    it 'n’affiche pas le numéro' do
      (1..nombre_scenes).each do |num|
        expect(code).to have_tag("div#scene-#{num}") do
          without_tag('span.numero')
          with_tag('span.effet')
        end
      end
    end
  end
  # /sans numéro

  context 'sans effet' do
    before(:all) do
      extract_sequencier(no_effet: true)
    end
    it 'n’affiche pas l’effet' do
      (1..4).each do |num|
        expect(code).to have_tag("div#scene-#{num}") do
          with_tag('span.numero')
          without_tag('span.effet')
        end
      end
    end
  end
  # /sans effet

  context 'sans lieu' do
    before(:all) do
      extract_sequencier(no_lieu: true)
    end
    it 'n’affiche pas le lieu' do
      (1..nombre_scenes).each do |num|
        expect(code).to have_tag("div#scene-#{num}") do
          with_tag('span.numero', text: num)
          without_tag('span.lieu')
        end
      end
    end
  end
  # /sans lieu

  context 'sans décor' do
    before(:all) do
      extract_sequencier(no_decor: true)
    end
    it 'n’affiche pas le décor (mais affiche le lieu)' do
      (1..nombre_scenes).each do |num|
        expect(code).to have_tag("div#scene-#{num}") do
          with_tag('span.numero', text: num)
          with_tag('span.lieu')
          without_tag('span.decor')
        end
      end
    end
  end

end
