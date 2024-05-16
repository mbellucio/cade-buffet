require 'rails_helper'

describe 'Company edits event pricing' do
  it 'with success' do
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
    event = Event.create!(
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
    pricing = Pricing.create!(category: "Weekday")
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing.id,
      base_price: 4000,
      extra_person_fee: 300,
      extra_hour_fee: 500
    )
    #act
    login_as(company, :scope => :company)
    visit event_path(event.id)
    within("div#pricing-#{pricing.id}") do
      click_on "Editar"
    end
    fill_in "Preço base (10 pessoas)", with: 2000
    fill_in "Adicional por pessoa", with: 200
    fill_in "Adicional por hora extra de evento", with: 300
    click_on "Enviar"
    #assert
    within("div#pricings") do
      expect(page).to have_content "Preço base (10 pessoas): R$ 2.000,00"
      expect(page).to have_content "Adicional por pessoa: R$ 200,00"
      expect(page).to have_content "Adicional por hora extra de evento: R$ 300,00"
    end
  end

  it "and cannot edit another buffet's event event pricing" do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
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
      company_id: company.id
    )
    pricing = Pricing.create!(category: "Weekday")
    company_2 = Company.create!(
      buffet_name: "some Buffet 2",
      company_registration_number: "74.391.888/0001-88",
      email: "company2@gmail.com",
      password: "safestpasswordever"
    )
    buffet_2 = Buffet.create!(
      email: "somecompany2@gmail.com",
      company_name: "some company 2",
      phone_number: "1123451232136",
      zip_code: "12321231231",
      adress: "some street 112312",
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
    event_pricing_2 = EventPricing.create!(
      event_id: event_2.id,
      pricing_id: pricing.id,
      base_price: 4000,
      extra_person_fee: 300,
      extra_hour_fee: 500
    )
    #act
    login_as(company, :scope => :company)
    visit edit_event_pricing_path(event_pricing_2.id)
    #assert
    expect(current_path).not_to eq edit_event_pricing_path(event_pricing_2.id)
    expect(page).to have_content "Você não tem acesso a este evento"
  end

  it "with invalid data" do
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
    event = Event.create!(
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
    pricing = Pricing.create!(category: "Weekday")
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing.id,
      base_price: 4000,
      extra_person_fee: 300,
      extra_hour_fee: 500
    )
    #act
    login_as(company, :scope => :company)
    visit event_path(event.id)
    within("div#pricing-#{pricing.id}") do
      click_on "Editar"
    end
    fill_in "Preço base (10 pessoas)", with: "string"
    fill_in "Adicional por pessoa", with: ""
    fill_in "Adicional por hora extra de evento", with: ""
    click_on "Enviar"
    #assert
    expect(page).to have_content "Edição não foi bem sucedida"
  end
end
