require 'rails_helper'

feature 'Visitor search for an character' do
  scenario 'Successfully' do
    character = create(:character, name: '3-D Man')
    visit root_path

    fill_in 'Search here', with: character.name
    click_on 'Search'

    expect(page).to have_css('h1', text: "Search results for #{character.name}:")
    expect(page).to have_css('h3', text: character.name)
  end
  
  scenario 'and see details about the character' do
    character = create(:character, name: '3-D Man')
    visit root_path

    fill_in 'Search here', with: character.name
    click_on 'Search'
    click_on character.name
    
    expect(page).to have_css('h3', text: character.name)
    expect(page).to have_css('p', text: character.modified)
    expect(page).to have_css('p', text: character.image)
  end
  scenario 'and see the related comics' do
    character = create(:character, marvel_id: 1011334, name: '3-D Man')
    visit character_path(character)
    click_on 'Comics'
    
    expect(page).to have_css('h4', text: 'Avengers: The Initiative (2007) #19')
    expect(page).to have_css('h4', text: 'Avengers: The Initiative (2007) #18')
    expect(page).to have_css('h4', text: 'Avengers: The Initiative (2007) #18
                                          (ZOMBIE VARIANT)')
    expect(page).to have_css('h4', text: 'Avengers: The Initiative (2007) #17')
    expect(page).to have_css('h4', text: 'Avengers: The Initiative (2007) #16')
    expect(page).to have_css('h4', text: 'Avengers: The Initiative (2007) #15')
    expect(page).to have_css('h4', text: 'Avengers: The Initiative (2007) #14')
    expect(page).to have_css('h4', text: 'Avengers: The Initiative (2007) #14
                                          (SPOTLIGHT VARIANT)')
    expect(page).to have_css('h4', text: 'Deadpool (1997) #44')
    expect(page).to have_css('h4', text: 'Marvel Premiere (1972) #37')
    expect(page).to have_css('h4', text: 'Marvel Premiere (1972) #36')
    expect(page).to have_css('h4', text: 'Marvel Premiere (1972) #35')
 
  end

  scenario 'and cant find any results' do
    visit root_path
    character = create(:character)
    string = 'string'

    fill_in 'Search here', with: string
    click_on 'Search'

    expect(page).to have_css('h2', text: "Sorry, we cant find any results for #{string}")

    expect(page).not_to have_css('h1', text: "Search results for
                                              #{character.name}:")
    expect(page).not_to have_css('h3', text: character.name)
    expect(page).not_to have_css('p', text: character.modified)
    expect(page).not_to have_css('p', text: character.image)
  end
end
