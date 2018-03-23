require 'rails_helper'

feature 'Visitor search for an character' do
  scenario 'Successfully' do
    
    visit root_path
    spider = 'Spider'
    
    fill_in 'Search here', with spider
    click_on 'Search'
    
    expect(page).to have_css('h1', text: "Search results for #{spider} : ")
  end
end