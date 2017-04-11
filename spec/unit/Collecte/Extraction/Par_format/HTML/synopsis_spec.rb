describe 'Extration sous forme de synopsis' do
  let(:collecte) { @collecte }
  let(:film) { @film ||= collecte.film }
  let(:extracteur) { @extracteur ||= collecte.extractor }
  let(:code) { @code ||= File.read(extracteur.final_file.path) }
  context 'sans horloge demandé' do
    before(:all) do
      @collecte = Collecte.new(folder_test_2)
      # @collecte.parse
      @collecte.extract(
        format:  :html,
        as: :synopsis,
        horloge: false
      )
      @extracteur = @collecte.extractor
    end
    describe 'le code' do
      it 'contient le bon titre' do
        expect(code).to have_tag('div#titre', text: "Synopsis complet du film “Éverest”")
      end
      it 'ne contient pas la timeline' do
        expect(code).not_to have_tag('div.timeline')
      end
      it 'ne contient pas les horloges' do
        expect(code).not_to have_tag('span.horloge')
      end
      it 'contient les fiches personnages' do
        expect(code).to have_tag('div.fiche.personnage')
      end
      it 'contient les styles pour les fiches' do
        expect(code).to include 'div.fiche{'
      end
      it 'contient le javascript pour les fiches' do
        expect(code).to include 'function ShowPersonnage(oid)'
      end
      it 'ne contient pas les fiches brins' do
        expect(code).not_to have_tag('div.fiche.brin')
      end
      it 'ne contient plus de balises [PERSO#...]' do
        expect(code).not_to include '[PERSO#'
      end
      it 'contient les paragraphes quand la scène en a, les résumés dans le cas contraire' do
        # Pour que les méthodes `to_html` ci-dessous tiennent compte
        # du fait que c'est du format synopsis HTML
        Film::TextObjet.init(format: :html, as: :synopsis)
        film.scenes.each do |sid, scene|
          if scene.paragraphes.count > 0
            expect(code).not_to have_tag('div.scene', text: scene.resume.to_html)
            scene.paragraphes.each do |paragraphe|
              par = paragraphe.to_html.gsub(/<(.*?)>/,'')
              par = Regexp.escape(par)
              expect(code).to have_tag('div.scene', with:{id: "scene-#{sid}"}, text: /#{par}/)
            end
          else
            expect(code).to have_tag('div.scene', with:{id: "scene-#{sid}"}, text: scene.resume.to_html)
          end
        end
      end
    end
  end

  context 'avec horloge demandée' do
    before(:all) do
      @collecte = Collecte.new(folder_test_2)
      @collecte.extract(
        format:  :html,
        as: :synopsis,
        horloge: true
      )
    end
    describe 'le code du fichier final' do
      it 'contient le bon titre' do
        expect(code).to have_tag('div#titre', text: "Synopsis complet du film “Éverest”")
      end
      it 'contient les horloges' do
        expect(code).to have_tag('span.horloge', count: film.scenes.count)
      end
    end
  end
end
