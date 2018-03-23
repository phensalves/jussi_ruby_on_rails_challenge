require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'success' do
   
   visit root_path
   
   expect(current_path).to eq root_path
   expect(page).to have_content 'Welcome to Marvels characters search'

  end
end
