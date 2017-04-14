describe 'Extraction d’un résumé' do
  let(:collecte) { @collecte }
  let(:extracteur) { @extracteur ||= collecte.extractor }
  let(:finalfile) { @finalfile ||= extracteur.final_file }
  let(:code) { @code ||= finalfile.read }
  context 'avec seulement :as => :resume (sans format)' do
    before(:all) do
      @collecte = Collecte.new(folder_test_1)
      @final_path = File.join(folder_test_1, 'extraction', 'resume.html')
      File.unlink(@final_path) if File.exist?(@final_path)
      expect(File.exist?@final_path).to eq false
      @collecte.extract(as: :resume)
    end
    it 'produit le fichier résumé' do
      expect(File.exist?@final_path).to eq true
    end
    describe 'le code du fichier résumé' do
      it 'contient le bon titre' do
        expect(code).to have_tag('div#titre', text: "Résumé complet")
      end
      it 'contient une section .resumes' do
        expect(code).to have_tag('section.resumes')
      end
      it 'contient tous les résumés de scènes' do
        expect(code).to have_tag('section.resumes') do
          collecte.film.scenes.each do |sid, scene|
            with_tag('span.resume', text: scene.resume.only_str)
          end
        end
      end
      it 'contient la feuille de styles' do
        expect(code).to include 'span.resume:after{'
      end
    end
  end
end
