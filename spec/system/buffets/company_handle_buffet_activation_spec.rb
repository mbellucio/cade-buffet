require 'rails_helper'

describe 'Company handle buffet activation' do
  it 'and desactivate it' do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    buffet = Buffet.create!(
      email: "somecompany@gmail.com",
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
    login_as(company, scope: :company)
    visit buffet_path(buffet.id)
    click_on "Desativar Buffet"
    #assert
    expect(current_path).to eq buffet_path(buffet.id)
    expect(page).to have_content "Este Buffet está desativado"
    expect(page).to have_button "Reativar Buffet"
  end

  it "and activate it" do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    buffet = Buffet.create!(
      email: "somecompany@gmail.com",
      company_name: "some company",
      phone_number: "112345556",
      zip_code: "123231231",
      adress: "some street 1000",
      neighborhood: "some district",
      city: "some city",
      state_code: "CA",
      description: "A nice buffet",
      company_id: company.id,
      active: false
    )
    #act
    login_as(company, scope: :company)
    visit buffet_path(buffet.id)
    click_on "Reativar Buffet"
    #assert
    expect(current_path).to eq buffet_path(buffet.id)
    expect(page).not_to have_content "Este Buffet está desativado"
    expect(page).to have_button "Desativar Buffet"
  end
end
