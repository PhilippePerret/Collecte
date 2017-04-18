describe 'Extraction au format :html' do

  # Méthode principale pour construire le div qui contient
  # un label et une valeur
  def div_libval label, valeur
    "<div class=\"libval\"><span class=\"label\">#{label}</span><span class=\"value\">#{valeur}</span></div>"
  end

  before(:all) do
    @collecte = Collecte.new(folder_test_2)
    @collecte.parse
  end
  let(:collecte) { @collecte }
  let(:film) { @film ||= collecte.film }
  let(:code) { @code }

  describe 'de toutes les données' do
    before(:all) do
      File.unlink(@collecte.extractor(:html).final_file.path) if File.exist?(@collecte.extractor(:html).final_file.path)
      expect(File.exist? @collecte.extractor(:html).final_file.path).to eq false
      @collecte.extract(format: :html, open_file: false)

      col = Collecte.new(folder_test_2)
      col.film.load
      col.extract(format: :html, open_file: false)
      @code = File.read(col.extractor(:html).final_file.path)

    end
    it 'produit le fichier contenant les données extraites' do
      expect(File.exist? collecte.extractor(:html).final_file.path).to eq true
    end

    describe 'produit un fichier contenant' do
      it 'la balise générale du doctype' do
        expect(code).to include '<!DOCTYPE'
      end
      it 'la balise générale <html>' do
        expect(code).to include '<html lang="fr">'
        expect(code).to include '</html>'
      end
      it 'la balise <head>' do
        expect(code).to include '<head>'
        expect(code).to include '</head>'
      end

      it 'la marque principale du film' do
        expect(code).to include 'FILM : Everest2016'
      end
      describe 'la métadonnée ' do
        it 'identifiant du film' do
          expect(code).to include div_libval('id', 'Everest2016')
        end
        it 'titre du film' do
          expect(code).to include div_libval('titre', 'Éverest')
        end
        it 'auteurs de la collecte' do
          expect(code).to include div_libval('auteurs', 'Phil et Benoit')
        end
        it 'date de début de collecte' do
          expect(code).to include div_libval('debut', '25/4/2017')
        end
        it 'date de fin de collecte' do
          expect(code).to include div_libval('fin', '30/4/2017')
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
              sexe:'Femme',
              fonction:'Antagoniste', description:'Description de l\'antagoniste.'
            }
          ].each do |hperso|
            expect(code).to match /^<div(.*?)>Personnage #{hperso[:id]}<\/div>$/
            hperso.each do |prop,valu|
              expect(code).to include div_libval(prop, valu)
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
            expect(code).to match /<div(.*?)>Brin #{hbrin[:id]}<\/div>/
            hbrin.each do |prop,valu|
              expect(code).to include div_libval(prop, valu)
            end
          end
        end
      end
      # /Brins

      describe 'les données des décors' do
        it 'le titre de la section' do
          expect(code).to include '=== DÉCORS ==='
        end
        [
          {
            id: 1,
            decor: 'MAISON DE JOE',
            scenes_ids: '[1, 3, 4]',
          },
          {
            id: 2, decor: 'JARDIN PUBLIC',
            scenes_ids: '[2, 3]'
          }
        ].each do |hdecor|
          it "les données du décors #{hdecor.inspect}" do
            expect(code).to match /<div(.*?)>Décor #{hdecor[:id]}<\/div>/
            hdecor.each do |prop,valu|
              expect(code).to include div_libval(prop, valu)
            end
          end
        end
      end
      describe 'les données des scènes' do
        it 'le titre de la section' do
          expect(code).to include '=== SCENES ==='
        end
        [
          {
            id:1, numero:1,
            resume: {:raw=>"Résumé de la première scène. b1 (6)", :notes_ids=>'[6]', :brins_ids=>'[1]', :scene_id=>'1'},
            horloge:'0:00:30',
            effet:'JOUR', decors_ids: '[1]',
            brins_ids: '[1]', notes_ids: '[6]'
          },
          {
            id:2, numero:2,
            resume:{:raw=>'Résumé de la deuxième scène avec [PERSO#prota]. b2 b1', :brins_ids=>'[2, 1]', :scene_id=>'2'},
            horloge: '0:01:40', effet:'NUIT',
            decors_ids: '[2]',
            brins_ids: '[2, 1]', notes_ids: '[4, 5, 6]',
            paragraphes: [
              {index:0, raw:'Premier beat de la deuxième scène avec [PERSO#anta].'},
              {index:1, raw:'Deuxième beat de la deuxième scène avec [PERSO#prota]. (4)(5)(6)'},
              {index:2, raw:'Troisième beat de la deuxième scène.'}
            ]
          },
          {
            id:3, numero:3,
            resume:{:raw=>'Résumé de la troisième. (3) b1 b3', :notes_ids=>'[3]', :brins_ids=>'[1, 3]', :scene_id=>3},
            horloge:'0:03:20',
            effet:'JOUR',
            decors_ids:'[1, 2]',
            brins_ids:'[1, 3, 2]', notes_ids:'[3, 1]',
            paragraphes: [
              {index:0, raw:'Paragraphe 1 de troisième. Avec première note. (1)'},
              {index:1, raw:'Paragraphe 2 de troisième. Avec deuxième brin. b2'}
            ]
          }
        ].each do |hscene|
          it "les données de la scène ##{hscene[:id]}" do
            expect(code).to match /<div(.*?)>Scene #{hscene[:numero]}<\/div>/

            data_resume       = hscene.delete(:resume)
            data_paragraphes  = hscene.delete(:paragraphes)

            data_resume.each do |prop,valu|
              expect(code).to include div_libval(prop, valu)
            end

            hscene.each do |prop,valu|
              expect(code).to include div_libval(prop, valu)
            end

            # Test sur les paragraphes
            if data_paragraphes
              data_paragraphes.each do |hparag|
                expect(code).to match /<div(.*?)>Paragraphe #{hparag[:index]}<\/div>/
                expect(code).to include div_libval( 'raw', hparag[:raw] )
              end
            end
          end
        end
      end
    end
  end
end
