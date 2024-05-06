require 'rails_helper'
describe 'Company view event details' do
  it 'successfully' do
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
      name: "event1",
      description: "muito legal!",
      min_quorum: 10,
      max_quorum: 50,
      standard_duration: 240,
      menu: "Cachorro quente e batata frita",
      serve_alcohol: true,
      handle_decoration: true,
      valet_service: false,
      flexible_location: true,
      buffet_id: buffet.id
    )
    #act
    login_as(company, :scope => :company)
    visit buffet_path(buffet.id)
    click_on "event1"
    #assert
    within("div#event-details") do
      expect(page).to have_content "event1"
      expect(page).to have_content "muito legal!"
      expect(page).to have_content "240"
      expect(page).to have_content "Cachorro quente e batata frita"
      expect(page).to have_content "Serve bebida alcoólica: Sim"
    end
  end

  it "and go back to buffet details" do
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
      name: "event1",
      description: "muito legal!",
      min_quorum: 10,
      max_quorum: 50,
      standard_duration: 240,
      menu: "Cachorro quente e batata frita",
      serve_alcohol: true,
      handle_decoration: true,
      valet_service: false,
      flexible_location: true,
      buffet_id: buffet.id
    )
    #act
    login_as(company, :scope => :company)
    visit buffet_path(buffet.id)
    click_on "event1"
    click_on "Voltar"
    #assert
    expect(current_path).to eq(buffet_path(buffet.id))
  end

  it "and cannot see another buffet event" do
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
      name: "event1",
      description: "muito legal!",
      min_quorum: 10,
      max_quorum: 50,
      standard_duration: 240,
      menu: "Cachorro quente e batata frita",
      serve_alcohol: true,
      handle_decoration: true,
      valet_service: false,
      flexible_location: true,
      buffet_id: buffet.id
    )
    company_2 = Company.create!(
      buffet_name: "some Buffet 2",
      company_registration_number: "74.391.888/0001-88",
      email: "company2@gmail.com",
      password: "safestpasswordever"
    )
    buffet_2 = Buffet.create!(
      email: "somecompany2@gmail.com",
      company_name: "some company 2",
      phone_number: "11232316",
      zip_code: "12321231231",
      adress: "some street 123123",
      neighborhood: "some district 2",
      city: "some city 2",
      state_code: "NY",
      description: "A nice buffet too",
      company_id: company_2.id
    )
    event_2 = Event.create!(
      name: "event1",
      description: "muito legal!",
      min_quorum: 10,
      max_quorum: 50,
      standard_duration: 240,
      menu: "Cachorro quente e batata frita",
      serve_alcohol: true,
      handle_decoration: true,
      valet_service: false,
      flexible_location: true,
      buffet_id: buffet_2.id
    )
    #act
    login_as(company, :scope => :company)
    visit event_path(event_2.id)
    #assert
    expect(current_path).not_to eq event_path(event_2.id)
    expect(page).to have_content "Você não tem acesso a este evento"
  end
end
