require 'rails_helper'

feature 'visitor_see_all_character' do
  scenario 'successfully' do
    character = create(:character, name: 'Spider')
    character2 = create(:character, name: 'Super')
    character3 = create(:character)

    visit characters_path

    expect(page).to have_css('h3', text: character.name)
    expect(page).to have_css('p', text: character.modified)
    expect(page).to have_css('p', text: character.image)

    expect(page).to have_css('h3', text: character2.name)
    expect(page).to have_css('p', text: character2.modified)
    expect(page).to have_css('p', text: character2.image)

    expect(page).to have_css('h3', text: character3.name)
    expect(page).to have_css('p', text: character3.modified)
    expect(page).to have_css('p', text: character3.image)
  end
end
