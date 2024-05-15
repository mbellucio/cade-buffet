require 'rails_helper'

describe 'Visitant view all buffets' do
  it 'and dont see the desactivated ones' do
    #arrange
    company_1 = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    company_2 = Company.create!(
      buffet_name: "some other Buffet",
      company_registration_number: "74.391.888/0001-97",
      email: "company2@gmail.com",
      password: "safestpasswordever"
    )
    company_3 = Company.create!(
      buffet_name: "some other another Buffet",
      company_registration_number: "74.391.888/0001-90",
      email: "company3@gmail.com",
      password: "safestpasswordever"
    )
    Buffet.create!(
      email: "somecompany@gmail.com",
      company_name: "some company",
      phone_number: "112345556",
      zip_code: "123231231",
      adress: "some street 1000",
      neighborhood: "some district",
      city: "some city",
      state_code: "CA",
      description: "A nice buffet",
      company_id: company_1.id
    )
    Buffet.create!(
      email: "somecompany2@gmail.com",
      company_name: "some company 2",
      phone_number: "21312534556",
      zip_code: "123125657654",
      adress: "some street 1200",
      neighborhood: "some district 2",
      city: "some city 2",
      state_code: "NY",
      description: "A nice buffet 2",
      company_id: company_2.id
    )
    Buffet.create!(
      email: "somecompany3@gmail.com",
      company_name: "some company 3",
      phone_number: "213123123123",
      zip_code: "12123213123",
      adress: "some street 2400",
      neighborhood: "some district 3",
      city: "some city 3",
      state_code: "AL",
      description: "A nice buffet 3",
      company_id: company_3.id,
      active: false
    )
    #act
    visit root_path
    #assert
    expect(page).to have_content "some Buffet"
    expect(page).to have_content "some other Buffet"
    expect(page).not_to have_content "some other another Buffet"
  end
end
