describe 'Extraction des brins' do
  let(:collecte) { @collecte }
  let(:code) { @code }
  context 'avec un filtre sur un seul brin' do
    before(:all) do
      extract_brin([1])
    end
    it 'affiche seulement les scènes de ce brin' do
      [1,2,3,4,5].each do |num|
        expect(code).to have_tag("div#scene-#{num}")
      end
      [6].each do |num|
        expect(code).not_to have_tag("div#scene-#{num}")
      end
    end
  end

end
