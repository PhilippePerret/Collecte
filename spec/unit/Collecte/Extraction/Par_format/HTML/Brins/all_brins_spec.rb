describe 'Extraction HTML de tous les brins' do
  let(:collecte) { @collecte }
  let(:extracteur) { @extracteur }
  let(:code) { @code }
  let(:dossier_extraction) { @dossier_extraction ||= extracteur.final_file.folder }
  describe 'l’argument :all_brins_html dans #extract' do
    before(:all) do
      @collecte = Collecte.new(folder_test_4)
      @extracteur = @collecte.extractor(:html)
    end
    it 'ne produit pas d’erreur' do
      expect{collecte.extract(:all_brins_html)}.not_to raise_error
    end
    it 'produit tous les fichiers brins' do
      FileUtils.rm_rf(dossier_extraction) if File.exist?(dossier_extraction)
      collecte.parse
      collecte.extract(:all_brins_html)
      expect(File.exist?(dossier_extraction)).to eq true
      (1..6).each do |bid|
        expect(File.exist?(File.join(dossier_extraction,"full_brin_#{bid}.html"))).to eq true
      end
    end
    it 'chaque fichier brin contient bien ses scènes' do
      {
        1 => [1,2,3,4,5],
        2 => [2,4,7],
        3 => [3,4,5],
        4 => [4],
        5 => [],
        6 => [4]
      }.each do |brin_id, scenes_in|
        scenes_out = (1..7).reject{|i| scenes_in.include?(i)}
        path = File.join(dossier_extraction,"full_brin_#{brin_id}.html")
        code = File.read(path)
        if scenes_in.count > 0
          expect(code).to have_tag('section#sequencier.scenes')do
            scenes_in.each do |sid|
              with_tag("div#scene-#{sid}")
            end
            scenes_out.each do |sid|
              without_tag("div#scene-#{sid}")
            end
          end
        else
          expect(code).not_to have_tag('section#sequencier')
        end
      end
    end

    describe 'contenu des fichiers brins' do
      context 'le fichier brin 2 quand tous les brins avec option :no_resume_when_paragraphes' do
        before(:all) do
          dossier_extraction = File.join(folder_test_4, 'extraction')
          FileUtils.rm_rf(dossier_extraction) if File.exist?(dossier_extraction)
          @collecte = Collecte.new(folder_test_4)
          # @collecte.parse # Si modifications
          @collecte.extract(:all_brins_html, :no_resume_when_paragraphes => true)
          fichier_brin2 = File.join(dossier_extraction,'full_brin_2.html')
          expect(File.exist?fichier_brin2).to eq true
          @code = File.read(fichier_brin2)
        end
        describe 'son code' do
          it 'contient le bon titre' do
            expect(code).to have_tag('div#titre', text: 'Brin 2 (Deuxième brin) complet du film “Film pour brins”')
          end
          it 'contient les trois scènes du brin' do
            [2,4,7].each do |sid|
              expect(code).to have_tag("div#scene-#{sid}")
            end
          end
          it 'NE contient PAS le résumé de la scène 2 (indirectement dans le brin)' do
            expect(code).to have_tag('div#scene-2') do
              without_tag('div.resume')
            end
          end
          it 'ne contient pas de div.paragraphes pour la scène 2' do
            expect(code).to have_tag('div#scene-2') do
              without_tag('div.paragraphes')
            end
          end
          it 'contient le paragraphe concerné de la scène 2 (le 2e)' do
            expect(code).to have_tag('div#scene-2') do
              with_tag('div#paragraphe-1', with:{class: 'paragraphe'}, text: /Le premier paragraphe appartient au brin 2/)
            end
          end
          it 'NE contient PAS le résumé de la scène 4 (indirectement concernée)' do
            expect(code).to have_tag('div#scene-4') do
              without_tag('div.resume')
            end
          end
          it 'ne contient pas de div.paragraphes pour la scène 4' do
            expect(code).to have_tag('div#scene-4') do
              without_tag('div.paragraphes')
            end
          end
          it 'contient le 5e paragraphe de la scène 4' do
            expect(code).to have_tag('div#scene-4') do
              with_tag('div#paragraphe-5', with:{class: 'paragraphe'}, text: /Paragraphe 5 de quatrième scène appartient au brin 2/)
            end
          end
          it 'contient le résumé de la 7e scène (concernée directement)' do
            expect(code).to have_tag('div#scene-7') do
              with_tag('div.resume', text: /Septième scène dans le brin 2 seulement/)
            end
          end
          it 'ne contient aucun des paragraphes de la 7e scène' do
            expect(code).to have_tag('div#scene-7') do
              without_tag('div.paragraphe')
            end
          end
        end
      end



      context 'le fichier brin 2 quand tous les brins sans option particulière' do
        before(:all) do
          dossier_extraction = File.join(folder_test_4, 'extraction')
          FileUtils.rm_rf(dossier_extraction) if File.exist?(dossier_extraction)
          @collecte = Collecte.new(folder_test_4)
          # @collecte.parse # Si modifications
          @collecte.extract(:all_brins_html)
          fichier_brin2 = File.join(dossier_extraction,'full_brin_2.html')
          expect(File.exist?fichier_brin2).to eq true
          @code = File.read(fichier_brin2)
        end
        it 'le code contient les trois scènes du brin' do
          [2,4,7].each do |sid|
            expect(code).to have_tag("div#scene-#{sid}")
          end
        end
        it 'contient le résumé de la scène 2 (indirectement dans le brin)' do
          expect(code).to have_tag('div#scene-2') do
            with_tag('div.resume', text: /Deuxième scène de Joe Prota et d'André dans brin 2 et 1/)
          end
        end
        it 'contient le paragraphe concerné de la scène 2 (le 2e)' do
          expect(code).to have_tag('div#scene-2') do
            with_tag('div#paragraphe-1', with:{class: 'paragraphe'}, text: /Le premier paragraphe appartient au brin 2/)
          end
        end
        it 'contient le résumé de la scène 4 (indirectement concernée)' do
          expect(code).to have_tag('div#scene-4') do
            with_tag('div.resume', text: /Quatrième scène dans brins 1, 2, 3, 4, 6/)
          end
        end
        it 'contient le 5e paragraphe de la scène 4' do
          expect(code).to have_tag('div#scene-4') do
            with_tag('div#paragraphe-5', with:{class: 'paragraphe'}, text: /Paragraphe 5 de quatrième scène appartient au brin 2/)
          end
        end
        it 'contient le résumé de la 7e scène' do
          expect(code).to have_tag('div#scene-7') do
            with_tag('div.resume', text: /Septième scène dans le brin 2 seulement/)
          end
        end
        it 'ne contient aucun des paragraphes de la 7e scène' do
          expect(code).to have_tag('div#scene-7') do
            without_tag('div.paragraphe')
          end
        end
      end
    end
  end
end
