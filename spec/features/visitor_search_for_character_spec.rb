require 'rails_helper'

feature 'Visitor search for an character' do
  scenario 'Successfully' do
    
    visit root_path
    character = create(:character)
    
    fill_in 'Search here', with: character.name
    click_on 'Search'
    
    expect(page).to have_css('h1', text: "Search results for #{character.name}:")
    expect(page).to have_css('h3', text: character.name)
    expect(page).to have_css('p', text: character.modified)
    expect(page).to have_css('p', text: character.image)
    
  end
end