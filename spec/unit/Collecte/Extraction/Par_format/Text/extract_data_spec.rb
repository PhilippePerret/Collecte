describe 'Extraction au format :text' do
  before(:all) do
    @collecte = Collecte.new(folder_test_2)
    @collecte.parse
  end
  let(:collecte) { @collecte }
  let(:film) { @film ||= collecte.film }
  let(:code) { @code }

  describe 'de toutes les données' do
    before(:all) do
      File.unlink(@collecte.extractor(:text).final_file.path) if File.exist?(@collecte.extractor(:text).final_file.path)
      expect(File.exist? @collecte.extractor(:text).final_file.path).to eq false
      @collecte.extract(format: :text, open_file: false)

      col = Collecte.new(folder_test_2)
      col.film.load
      col.extract(format: :text, open_file: false)
      @code = File.read(col.extractor(:text).final_file.path)

    end
    it 'produit le fichier contenant les données extraites' do
      expect(File.exist? collecte.extractor(:text).final_file.path).to eq true
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
          [
            {
              id:1, libelle:'Premier brin',
              description:'Description du premier brin.'
            },
            {
              id:2, libelle:'Deuxième brin',
              description:'Une description du deuxième brin.'
            },
            {id:3, libelle:'Troisième brin', description:''},
            {id:4, libelle:'Quatrième brin', description:''},
            {
              id:5, libelle:'Cinquième brin inutilisé par la collecte.',
              description:''
            }
          ].each do |hbrin|
            expect(code).to match /^Brin #{hbrin[:id]}$/
            hbrin.each do |prop,valu|
              expect(code).to match /^\t#{prop}(.*?)#{valu}$/
            end
          end
        end
      end
      # /Brins

      describe 'les données des scènes' do
        it 'le titre de la section' do
          expect(code).to include '=== SCENES ==='
        end
        [
          {
            id:1, numero:1,
            resume: '{:raw=>"Résumé de la première scène. b1 (6)", :only_str=>"Résumé de la première scène.", :personnages_ids=>[], :notes_ids=>[6], :brins_ids=>[1], :scene_id=>1, :scenes_ids=>nil, :horloge=>nil}',
            horloge:'0:00:30',
            lieu:'INT.', effet:'JOUR', decor:'MAISON DE JOE',
            brins_ids: '1', notes_ids: '6'
          },
          {
            id:2, numero:2,
            resume:'{:raw=>"Résumé de la deuxième scène avec [PERSO#prota]. b2 b1", :only_str=>"Résumé de la deuxième scène avec [PERSO#prota].", :personnages_ids=>["prota"], :notes_ids=>[], :brins_ids=>[2, 1], :scene_id=>2, :scenes_ids=>nil, :horloge=>nil}',
            horloge: '0:01:40', lieu:'EXT.', effet:'NUIT', decor:'JARDIN PUBLIC',
            brins_ids: '2,1', notes_ids: '4,5,6',
            paragraphes: [
              {index:0, raw:'Premier beat de la deuxième scène avec [PERSO#anta].'},
              {index:1, raw:'Deuxième beat de la deuxième scène avec [PERSO#prota]. (4)(5)(6)'},
              {index:2, raw:'Troisième beat de la deuxième scène.'}
            ]
          },
          {
            id:3, numero:3,
            resume:'{:raw=>"Résumé de la troisième. (3) b1 b3", :only_str=>"Résumé de la troisième.", :personnages_ids=>[], :notes_ids=>[3], :brins_ids=>[1, 3], :scene_id=>3, :scenes_ids=>nil, :horloge=>nil}',
            horloge:'0:03:20',
            lieu:'INT.', lieu_alt:'EXT.',
            effet:'JOUR',
            decor:'MAISON DE JOE', decor_alt:'JARDIN PUBLIC',
            brins_ids:'1,3,2', notes_ids:'3,1',
            paragraphes: [
              {index:0, raw:'Paragraphe 1 de troisième. Avec première note. (1)'},
              {index:1, raw:'Paragraphe 2 de troisième. Avec deuxième brin. b2'}
            ]
          }
        ].each do |hscene|
          it "les données de la scène ##{hscene[:id]}" do
            expect(code).to match /^Scene #{hscene[:numero]}$/

            dparagraphes = hscene.delete(:paragraphes)

            hscene.each do |prop,valu|
              valu =
                case prop
                when :resume then Regexp::escape(valu)
                else valu
                end
              expect(code).to match /^\t#{prop}(.*?)#{valu}$/
            end

            # Test sur les paragraphes
            if dparagraphes
              dparagraphes.each do |hparag|
                expect(code).to match /^\tParagraphe #{hparag[:index]}$/
                raw = Regexp.escape(hparag[:raw])
                expect(code).to match /^\t\traw(.*?)#{raw}$/
              end
            end

          end
        end
      end

    end

  end
end
