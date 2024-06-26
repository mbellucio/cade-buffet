require 'rails_helper'

describe 'Company deletes an event pricing' do
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
    pricing1 = Pricing.create!(category: "Weekday")
    pricing2 = Pricing.create!(category: "Weekend")
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing1.id,
      base_price: 4000,
      extra_person_fee: 300,
      extra_hour_fee: 500
    )
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing2.id,
      base_price: 7000,
      extra_person_fee: 400,
      extra_hour_fee: 900
    )
    #act
    login_as(company, :scope => :company)
    visit event_path(event.id)
    within("div#pricing-#{pricing2.id}") do
      click_on "Remover"
    end
    #assert
    expect(current_path).to eq event_path(event.id)
    sleep 1
    within("div#pricing-#{pricing2.id}") do
      expect(page).to have_link "Configurar"
      expect(page).not_to have_content "Preço base (10 pessoas): R$ 7.000,00"
      expect(page).not_to have_content "Adicional por pessoa: R$ 400,00"
      expect(page).not_to have_content "Adicional por hora extra de evento: R$ 900,00"
    end
  end

  it "fails if there are orders made with that event pricing" do
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
    event_pricing = EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing.id,
      base_price: 4000,
      extra_person_fee: 300,
      extra_hour_fee: 500
    )
    client = Client.create!(
      full_name: "Matheus Bellucio",
      social_security_number: "455.069.420-36",
      email: "matheus@gmail.com",
      password: "safestpasswordever"
    )
    Order.create!(
      company_id: company.id,
      client_id: client.id,
      event_pricing_id: event_pricing.id,
      booking_date: 1.day.from_now,
      predicted_guests: 30,
      event_details: "details",
      event_adress: "some street 10",
      status: :pending
    )
    #act
    login_as(company, scope: :company)
    visit event_path(event.id)
    within("div#pricing-#{pricing.id}") do
      click_on "Remover"
    end
    #assert
    expect(page).to have_content "Existem pedidos ativos com esta precificação, impossível deletar."
    within("div#pricing-#{pricing.id}") do
      expect(page).to have_button "Remover"
    end
  end
end
