require 'rails_helper'

describe 'Company view order details' do
  it 'successfully' do
    #arrange
    company = Company.create!(
      buffet_name: "Buffet Legal",
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
      name: "Festa Infantil",
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
    pricing_weekday = Pricing.create!(category: "Weekday")
    event_pricing = EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing_weekday.id,
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return("AA44FF55")
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
    visit root_path
    within("nav") do
      click_on("Pedidos")
    end
    click_on "Pedido: AA44FF55"
    #assert
    expect(page).to have_content "Código do pedido: AA44FF55"
    expect(page).to have_content "Buffet: Buffet Legal"
    expect(page).to have_content "Evento: Festa Infantil"
    expect(page).to have_content "Número de convidados: 30"
    expect(page).to have_content "Data do evento: #{1.day.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Detalhes do evento: details"
    expect(page).to have_content "Aguardando avaliação do buffet"
  end

  it "and its warned if there are any other orders requested for the same date" do
     #arrange
    company = Company.create!(
      buffet_name: "Buffet Legal",
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
      name: "Festa Infantil",
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
    pricing_weekday = Pricing.create!(category: "Weekday")
    event_pricing = EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing_weekday.id,
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return("AA44FF55")
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return("BB77KK99")
    Order.create!(
      company_id: company.id,
      client_id: client.id,
      event_pricing_id: event_pricing.id,
      booking_date: 1.day.from_now,
      predicted_guests: 40,
      event_details: "details",
      event_adress: "another street 20",
      status: :pending
    )
    #act
    login_as(company, scope: :company)
    visit root_path
    within("nav") do
      click_on("Pedidos")
    end
    click_on "Pedido: AA44FF55"
    #assert
    expect(page).to have_content "Já existe um ou mais pedidos requeridos para esta data (#{1.day.from_now.strftime("%d/%m/%Y")})"
    expect(page).to have_content "Pedido: BB77KK99 - Festa Infantil"
  end

  it "cannot see other company user order" do
    #arrange
    company = Company.create!(
      buffet_name: "Buffet Legal",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    company_2 = Company.create!(
      buffet_name: "Buffet Legal 2",
      company_registration_number: "74.391.888/0001-88",
      email: "company2@gmail.com",
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
      company_id: company_2.id
    )
    Buffet.create!(
      email: "somecompany2@gmail.com",
      company_name: "some company 2",
      phone_number: "1112312356",
      zip_code: "11231231",
      adress: "some street 123123",
      neighborhood: "some district 2",
      city: "some city 2",
      state_code: "NY",
      description: "A nice buffet too",
      company_id: company.id
    )
    event = Event.create!(
      name: "Festa Infantil",
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
    pricing_weekday = Pricing.create!(category: "Weekday")
    event_pricing = EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing_weekday.id,
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
    order = Order.create!(
      company_id: company_2.id,
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
    visit order_path(order.id)
    #assert
    expect(current_path).not_to eq order_path(order.id)
    expect(page).to have_content "Você não tem acesso a este pedido"
  end
end
