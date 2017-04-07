describe 'Sortie sous forme de séquencier complet' do
  before(:all) do
    @collecte = Collecte.new(folder_test_3)
    @film = @collecte.film
    @collecte.parse
    @collecte.extract(format: :html, as: :outline)
    @code = File.read(@collecte.extractor(:html).final_file.path)
  end

  let(:collecte) { @collecte }
  let(:film) { @film }
  let(:code) { @code }

  describe 'Le code produit' do

    describe 'contient les données générales' do
      it 'doctype' do
        expect(code).to include '<!DOCTYPE'
      end
      it 'la balise html' do
        expect(code).to include '<html lang="fr">'
        expect(code).to include '</html>'
      end
    end

    describe 'contient pour le séquencier' do
      it 'son titre' do
        expect(code).to have_tag('div#titre', text: "Séquencier du film “Séquences”")
      end
      it 'sa section des scènes' do
        expect(code).to have_tag('section#scenes', with:{css: 'scenes_list'})
      end
    end
  end
end
