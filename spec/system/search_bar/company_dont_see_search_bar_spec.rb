require 'rails_helper'

describe 'Company dont see search bar' do
  it 'upon logging' do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    #act
    login_as(company)
    visit root_path
    #assert
    within("nav") do
      expect(page).not_to have_button "Procurar"
      expect(page).not_to have_field "Procurar..."
    end
  end
end
