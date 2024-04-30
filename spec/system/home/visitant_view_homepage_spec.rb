require 'rails_helper'

describe 'Visitant access homepage' do
  it 'and see app name' do
    #arrange

    #act
    visit root_path
    #assert
    within("nav") do
      expect(page).to have_content "Cadê Buffet"
    end
  end

  it "and see buffet register link" do
    #arrange

    #act
    visit root_path
    #assert
    within("nav") do
      expect(page).to have_content("Empresas/Buffets")
    end
  end

  it "and see login link" do
    #arrange

    #act
    visit root_path
    #assert
    within("nav") do
      expect(page).to have_content("Entrar")
    end
  end

  it "and see all buffets listed" do
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
    #act
    visit root_path
    #assert
    within("div#buffets") do
      expect(page).to have_content "some Buffet"
      expect(page).to have_content "some city"
      expect(page).to have_content "CA"
      expect(page).to have_content "some other Buffet"
      expect(page).to have_content "some city 2"
      expect(page).to have_content "NY"
    end
  end
end
