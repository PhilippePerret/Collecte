describe 'Extraction' do
  before(:all) do
    @collecte = Collecte.new(folder_test_2)
    @collecte.parse
  end
  let(:collecte) { @collecte }
  let(:film) { @film ||= collecte.film }
  let(:code) { @code }

  describe 'de toutes les données sous forme Texte' do
    before(:all) do
      File.unlink(@collecte.extractor(:text).path) if File.exist?(@collecte.extractor(:text).path)
      expect(File.exist? @collecte.extractor(:text).path).to eq false
      @collecte.extract(format: :text, open_file: false)

      col = Collecte.new(folder_test_2)
      col.film.load
      col.extract(format: :text, open_file: false)
      @code = File.read(col.extractor(:text).path)

    end
    it 'produit le fichier contenant les données extraites' do
      expect(File.exist? collecte.extractor(:text).path).to eq true
    end

    describe 'contenant' do
      it 'la marque principale du film' do
        expect(code).to include 'Film : Everest2016'
      end
      describe 'la métadonnée ' do
        it 'identifiant du film' do
          expect(code).to match /^id(.*?)Everest2016$/
        end
        it 'titre du film' do
          expect(code).to match /^titre(.*?)Éverest$/
        end
        it 'auteurs de la collecte' do
          expect(code).to match /^auteurs(.*?)Phil et Benoit$/
        end
        it 'date de début de collecte' do
          expect(code).to match /^debut(.*?)25\/4\/2017/
        end
        it 'date de fin de collecte' do
          expect(code).to match /^fin(.*?)30\/4\/2017/
        end
      end
      # /describe la métadonnée

      describe 'les données personnages' do
        it 'le titre de la section' do
          expect(code).to include '=== PERSONNAGES ==='
        end
        it 'les données des personnages' do
          [
            {
              id: 'prota', prenom:'Prénom1', nom:'Nom Du Protagoniste',
              pseudo:'Le Protagoniste', sexe:'Homme', annee:2000,
              fonction:'Protagoniste', description:'Description du protagoniste.'
            },
            {
              id: 'anta', prenom:'Prénom2', nom:'Nom De l\'Antagoniste',
              pseudo:nil, sexe:'Femme', annee:nil,
              fonction:'Antagoniste', description:'Description de l\'antagoniste.'
            }
          ].each do |hperso|
            expect(code).to match /^Personnage #{hperso[:id]}$/
            hperso.each do |prop,valu|
              expect(code).to match /^\t#{prop}(.*?)#{valu}$/
            end
          end
        end
      end
      # /Personnages

      describe 'les données des brins' do
        it 'le titre de la section' do
          expect(code).to include '=== BRINS ==='
        end
      end
      # /Brins

      describe 'les données des scènes' do
        it 'le titre de la section' do
          expect(code).to include '=== SCENES ==='
        end
      end

    end

  end
end
