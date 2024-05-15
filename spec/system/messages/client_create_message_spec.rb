require 'rails_helper'

describe 'Client Create message' do
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
    order = Order.create!(
      company_id: company.id,
      client_id: client.id,
      event_pricing_id: event_pricing.id,
      booking_date: 1.day.from_now,
      predicted_guests: 30,
      event_details: "details",
      event_adress: "some street 10",
      status: :pending
    )
    company.messages.create(content: "Hello there", user_id: company.id, order_id: order.id)
    #act
    login_as(client, scope: :client)
    visit order_path(order.id)
    fill_in "escreva uma mensagem...",	with: "General Kenobi?"
    click_on "Enviar"
    #assert
    within("div#message-box") do
      expect(page).to have_content "Hello there"
      expect(page).to have_content "General Kenobi?"
    end
  end

  it "client cannot see chatbox and send messages if company didnt sent message first" do
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
    order = Order.create!(
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
    login_as(client, scope: :client)
    visit order_path(order.id)
    #assert
    expect(page).not_to have_field "escreva uma mensagem..."
    expect(page).not_to have_button "Enviar"
    expect(page).not_to have_content "Chat com o Buffet"
  end
end
