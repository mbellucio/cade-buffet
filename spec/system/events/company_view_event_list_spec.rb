require 'rails_helper'

describe 'Company view event list' do
  it 'and the list is empty' do
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
    login_as(company, :scope => :company)
    visit buffet_path(buffet.id)
    #assert
    within("div#events") do
      expect(page).to have_content("Não existem eventos cadastrados")
      expect(page).to have_link("Cadastrar evento")
    end
  end

  it "and see all registered events" do
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
    Event.create!(
      name: "Festa Infantil",
      description: "muito legal!",
      min_quorum: 10,
      max_quorum: 50,
      standard_duration: 240,
      menu: "Cachorro quente e batata frita",
      serve_alcohol: false,
      handle_decoration: true,
      valet_service: false,
      flexible_location: true,
      buffet_id: buffet.id
    )
    Event.create!(
      name: "Churrasco",
      description: "muito bom",
      min_quorum: 20,
      max_quorum: 100,
      standard_duration: 240,
      menu: "Picanha",
      serve_alcohol: true,
      handle_decoration: false,
      valet_service: false,
      flexible_location: true,
      buffet_id: buffet.id
    )
    #act
    login_as(company, :scope => :company)
    visit buffet_path(buffet.id)
    #assert
    within("div#events") do
      expect(page).to have_link("Festa Infantil")
      expect(page).to have_link("Churrasco")
      expect(page).not_to have_content("Não existem eventos cadastrados")
    end
  end
end
