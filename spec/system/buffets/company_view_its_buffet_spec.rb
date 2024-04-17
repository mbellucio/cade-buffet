require 'rails_helper'

describe 'Company view buffet' do
  it 'and access from the menu' do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    Buffet.create!(
      company_name: "some company",
      phone_number: "112345556",
      zip_code: "123231231",
      adress: "some street 1000",
      neighborhood: "some district",
      city: "some city",
      state_code: "CA",
      description: "A nice buffet",
      company_id: company.id
    )
    #act
    login_as(company)
    visit root_path
    click_on "Meu Buffet"
    #assert
    within("div#buffet-details") do
      expect(page).to have_content "some Buffet"
      expect(page).to have_content "some company"
      expect(page).to have_content "74.391.888/0001-77"
      expect(page).to have_content "company@gmail.com"
      expect(page).to have_content "112345556"
      expect(page).to have_content "123231231"
      expect(page).to have_content "some district"
      expect(page).to have_content "some city"
      expect(page).to have_content "CA"
      expect(page).to have_content "A nice buffet"
    end
  end
end
