describe 'Intitulé défini en option' do
  let(:collecte) { @collecte }
  let(:film) { collecte.film }
  let(:code) { @code }
  let(:nombre_scenes) { @nombre_de_scenes }

  context 'avec un template d’intitulé défini' do
    before(:all) do
      extract_sequencier(
        intitule: '%{numero}. %{lieu} // %{effet}'
      )
    end
    it 'affiche le bon intitulé' do
      (1..nombre_scenes).each do |num|
        scene = film.scenes[num]
        expect(code).to have_tag("div#scene-#{num}") do
          with_tag('span.numero')
          with_tag('span.lieu')
          with_tag('span.effet')
          without_tag('span.horloge')
          without_tag('span.decor')
          with_tag('div.intitule', text: "#{num}. #{scene.lieux} // #{scene.effets}")
        end
      end
    end
  end
  context 'avec un template définissant des styles' do
    before(:all) do
      extract_sequencier(
        intitule: '<span style="float:right">%{horloge}</span>%{decor} / %{effet}'
      )
    end
    it 'définit bien les intitulés' do
      (1..nombre_scenes).each do |num|
        scene = film.scenes[num]
        expect(code).to have_tag("div#scene-#{num}") do
          with_tag('span.effet')
          with_tag('span.horloge')
          with_tag('span.decor')
          without_tag('span.numero')
          without_tag('span.lieu')
          with_tag('div.intitule', text: "#{scene.horloge.horloge}#{scene.decors} / #{scene.effets}")
        end
      end
    end
  end
end
