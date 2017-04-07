describe 'Sortie sous forme de séquencier complet' do
  before(:all) do
    # On force le parsing dans le cas où il y ait des
    # modifications.
    Collecte.new(folder_test_3).parse

    # Nouvelle instance pour forcer le chargement
    @collecte = Collecte.new(folder_test_3)
    @collecte.extract(format: :html, as: :sequencier)
    @code = File.read(@collecte.extractor(:html).final_file.path)
    puts "@code = #{RC}#{@code}"
  end

  let(:collecte) { @collecte }
  let(:film) { @film ||= @collecte.film }
  let(:code) { @code }

  describe 'Vérification préliminaire' do
    it 'il y a des scènes' do
      expect(film.scenes.count).to be > 0
    end
  end
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
        expect(code).to have_tag('section#sequencier', with:{class: 'scenes'})
      end
    end
  end
end
