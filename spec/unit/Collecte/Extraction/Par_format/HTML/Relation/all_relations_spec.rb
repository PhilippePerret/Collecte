describe 'Extraction de toutes les relations' do
  let(:code) { @code }
  describe 'avec l’option :as => :all_relations_html' do
    before(:all) do
      parse_collecte(folder_test_5)
      dos_ext = File.join(folder_test_5, 'extraction')
      FileUtils.rm_rf dos_ext if File.exist? dos_ext
      @fpath1 = File.join(dos_ext, 'full_brin_relation_quatre_trois.html')
      @fpath2 = File.join(dos_ext, 'full_brin_relation_joe_trois.html')
      # ===> TEST <===
      expect(File.exist? @fpath1).to eq false
      expect(File.exist? @fpath2).to eq false
      @collecte.extract(as: :all_relations_html)
    end
    it 'produit tous les fichiers des relations' do
      expect(File.exist? @fpath1).to eq true
      expect(File.exist? @fpath2).to eq true
    end

    describe 'Le code du premier fichier relation quatre_trois' do
      before(:all) do
        @code = File.read(@fpath1)
      end
      it 'contient le bon titre' do
        expect(code).to have_tag('div#titre', text:'Brin de la relation entre Troisième Perso et Cento complet du film “Film pour divisions”')
      end
      it 'contient toutes les scènes du brin' do
        [6,7].each do |sid|
          expect(code).to have_tag('div', with:{id: "scene-#{sid}"})
        end
      end
      it 'ne contient pas les scènes hors de la relation' do
        [1,2,3,4,5,8].each do |sid|
          expect(code).not_to have_tag("div#scene-#{sid}")
        end
      end
    end


    describe 'Le code du second fichier relation joe_trois' do
      before(:all) do
        @code = File.read(@fpath2)
      end
      it 'contient le bon titre' do
        expect(code).to have_tag('div#titre', text:'Brin de la relation entre Joe Prota et Troisième Perso complet du film “Film pour divisions”')
      end
      it 'contient toutes les scènes du brin' do
        [7,8].each do |sid|
          expect(code).to have_tag('div', with:{id: "scene-#{sid}"})
        end
      end
      it 'ne contient pas les scènes hors de la relation' do
        [1,2,3,4,5,6].each do |sid|
          expect(code).not_to have_tag("div#scene-#{sid}")
        end
      end
    end
  end
end
