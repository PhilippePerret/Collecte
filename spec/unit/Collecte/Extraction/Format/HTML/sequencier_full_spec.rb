describe 'Sortie sous forme de séquencier complet' do
  before(:all) do
    # On force le parsing dans le cas où il y ait des
    # modifications.
    # Collecte.new(folder_test_3).parse

    # Nouvelle instance pour forcer le chargement
    @collecte = Collecte.new(folder_test_3)
    @collecte.extract(format: :html, as: :sequencier)
    @code = File.read(@collecte.extractor(:html).final_file.path)
    # puts "@code = #{RC}#{@code}"
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

    describe 'contient la premier scène' do
      it 'avec son div général div.scene#scene-1' do
        expect(code).to have_tag('div', with:{class: 'scene', id: "scene-1"})
      end
      it 'avec son intitulé correct' do
        expect(code).to have_tag('div#scene-1') do
          with_tag('div.intitule') do
            with_tag('span.horloge', text: '0:00:30')
            with_tag('span.lieu', text: 'INT.')
            with_tag('span.effet', text: 'JOUR')
            with_tag('span.decor', text: 'MAISON DE JOE')
          end
        end
      end
      it 'avec son résumé correct' do
        expect(code).to have_tag('div#scene-1') do
          with_tag('div.resume', text: /Résumé de la première scène/) do
            with_tag('a', text: 'Joe Prota')
            with_tag('a', text: 'Jan')
          end
        end
      end
      it 'avec ses liens vers les notes (la note)' do
        expect(code).to have_tag('div#scene-1') do
          with_tag('div.resume') do
            with_tag('sup') do
              with_tag('a', text: 'note 6', with: {href: '#', onclick:'return ShowNote(6)'})
            end
          end
        end
      end
      it 'avec ses liens vers les brins (le brin)' do
        expect(code).to have_tag('div#scene-1') do
          with_tag('div.resume') do
            with_tag('sup') do
              with_tag('a', text: 'brin 1', with: {href: '#', onclick: 'return ShowBrin(1)'})
            end
          end
        end
      end
    end
  end
end
