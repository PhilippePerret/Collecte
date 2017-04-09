describe 'Extraction des brins' do
  let(:collecte) { @collecte }
  let(:code) { @code }
  context 'avec un filtre sur un brin unique (1)' do
    before(:all) do
      extract_brin('1')
    end
    it 'affiche seulement les scènes de ce brin' do
      [1,2,3,4,5].each do |num|
        expect(code).to have_tag("div#scene-#{num}")
      end
      [6,7].each do |num|
        expect(code).not_to have_tag("div#scene-#{num}")
      end
    end
  end

  context 'avec un filtre sur 2 brins optionels : 2,4' do
    before(:all) do
      extract_brin('2,4')
    end
    it 'affiche les scènes du brin 2 OU du brin 4' do
      [2,4,7].each do |num|
        expect(code).to have_tag("div#scene-#{num}")
      end
      [1,3,5,6].each do |num|
        expect(code).not_to have_tag("div#scene-#{num}")
      end
    end
  end

  context 'avec un filtre sur 2 brins obligatoires : 1+3' do
    before(:all) do
      extract_brin('1+3')
    end
    it 'affiche les scènes appartenant aux brins 1 ET 3' do
      [3,4,5].each do |num|
        expect(code).to have_tag("div#scene-#{num}")
      end
      [1,2,6,7].each do |num|
        expect(code).not_to have_tag("div#scene-#{num}")
      end
    end
  end

  context 'avec le filtre complexe : (2,3)+1' do
    before(:all) do
      extract_brin('(2,3)+1')
    end
    it 'affiche les scènes appartenant aux brins 1 ET aux brins 2 OU 3' do
      [2,3,4,5].each do |num|
        expect(code).to have_tag("div#scene-#{num}")
      end
      [1,6,7].each do |num|
        expect(code).not_to have_tag("div#scene-#{num}")
      end
    end
  end

  context 'avec un filtre complexe : 1+(2,3)' do
    before(:all) do
      extract_brin('1+(2,3)')
    end
    it 'affiche les scènes appartenant aux brins 1 ET aux brins 2 OU 3' do
      [2,3,4,5].each do |num|
        expect(code).to have_tag("div#scene-#{num}")
      end
      [1,6,7].each do |num|
        expect(code).not_to have_tag("div#scene-#{num}")
      end
    end
  end

end
