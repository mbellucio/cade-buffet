require 'rails_helper'

describe 'Visitant view buffet details' do
  it 'successfully' do
    #arrange
    company = Company.create!(
      buffet_name: "some other Buffet",
      company_registration_number: "74.391.888/0001-97",
      email: "company2@gmail.com",
      password: "safestpasswordever"
    )
      buffet = Buffet.create!(
      email: "somecompany@gmail.com",
      payment_method: "pix, cc",
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
    visit root_path
    within("div#buffet-#{buffet.id}") do
      click_on "Ver detalhes"
    end
    #assert
    expect(page).to have_content "somecompany@gmail.com"
    expect(page).to have_content "112345556"
    expect(page).to have_content "some street 1000"
    expect(page).to have_content "CA"
  end
end
