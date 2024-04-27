require 'rails_helper'

describe 'Visitant sees search bar' do
  it 'successfully' do
    #arrange

    #act
    visit root_path
    #assert
    within("nav") do
      expect(page).to have_button "Procurar"
      expect(page).to have_field "Procurar..."
    end
  end
end
