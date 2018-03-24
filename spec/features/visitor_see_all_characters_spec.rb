require 'rails_helper'

feature 'visitor_see_all_character' do
    scenario 'successfully' do
        character = create(:character)
        visit characters_path
        
        expect(page).to have_css('h3', character.name)
        expect(page).to have_css('p', character.modified)
        expect(page).to have_css('p', character.image)
    end
end