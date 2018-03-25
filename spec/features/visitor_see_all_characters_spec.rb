require 'rails_helper'

feature 'visitor_see_all_character' do
  scenario 'successfully' do
    character = create(:character, name: 'Spider')
    character2 = create(:character, name: 'Super')
    character3 = create(:character)

    visit characters_path

    expect(page).to have_css('h3', character.name)
    expect(page).to have_css('p', character.modified)
    expect(page).to have_css('p', character.image)

    expect(page).to have_css('h3', character2.name)
    expect(page).to have_css('p', character2.modified)
    expect(page).to have_css('p', character2.image)

    expect(page).to have_css('h3', character3.name)
    expect(page).to have_css('p', character3.modified)
    expect(page).to have_css('p', character3.image)
  end
end
