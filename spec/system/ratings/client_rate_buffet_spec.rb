require 'rails_helper'

describe 'Client rate buffet' do
  it 'succesfully' do
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
      min_quorum: 30,
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
    payment_method = PaymentMethod.create(method: "PIX")
    BuffetPaymentMethod.create(
      buffet_id: buffet.id,
      payment_method_id: payment_method.id,
    )
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
      booking_date: 2.day.from_now,
      predicted_guests: 35,
      event_details: "details",
      event_adress: "some street 10",
      status: :confirmed
    )
    Budget.create!(
      order_id: order.id,
      payment_method_id: payment_method.id,
      proposal_deadline: 1.day.from_now,
    )
    #act
    travel 1.week
    login_as(client, scope: :client)
    visit buffet_path(buffet.id)
    click_on "Avaliar Buffet"
    fill_in "Nota",	with: 5
    fill_in "Descrição", with: "Muito bom!"
    attach_file "Foto", Rails.root.join("spec", "support", "buffet_img.jpg")
    click_on "Enviar avaliação"
    #assert
    expect(current_path).to eq buffet_path(buffet.id)
    within("div#ratings") do
      expect(page).to have_content "5/5"
      expect(page).to have_content "Por: Matheus Bellucio"
      expect(page).to have_content "Muito bom!"
      expect(page).to have_css('img[src*="buffet_img.jpg"]')
    end
  end

  it "Cant see rate button if he does not have a confirmed order" do
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
      min_quorum: 30,
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
    payment_method = PaymentMethod.create(method: "PIX")
    BuffetPaymentMethod.create(
      buffet_id: buffet.id,
      payment_method_id: payment_method.id,
    )
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
    Order.create!(
      company_id: company.id,
      client_id: client.id,
      event_pricing_id: event_pricing.id,
      booking_date: 2.day.from_now,
      predicted_guests: 35,
      event_details: "details",
      event_adress: "some street 10",
      status: :awaiting
    )
    #act
    login_as(client, scope: :client)
    visit buffet_path(buffet.id)
    #assert
    expect(page).not_to have_link "Avaliar Buffet"
  end

  it "Cant see rate button if he does not have a confirmed order that is in the past" do
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
      min_quorum: 30,
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
    payment_method = PaymentMethod.create(method: "PIX")
    BuffetPaymentMethod.create(
      buffet_id: buffet.id,
      payment_method_id: payment_method.id,
    )
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
    Order.create!(
      company_id: company.id,
      client_id: client.id,
      event_pricing_id: event_pricing.id,
      booking_date: 2.day.from_now,
      predicted_guests: 35,
      event_details: "details",
      event_adress: "some street 10",
      status: :confirmed
    )
    #act
    login_as(client, scope: :client)
    visit buffet_path(buffet.id)
    #assert
    expect(page).not_to have_link "Avaliar Buffet"
  end

  it "Cant see rating button if has already rated Buffet" do
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
      min_quorum: 30,
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
    payment_method = PaymentMethod.create(method: "PIX")
    BuffetPaymentMethod.create(
      buffet_id: buffet.id,
      payment_method_id: payment_method.id,
    )
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
    Order.create!(
      company_id: company.id,
      client_id: client.id,
      event_pricing_id: event_pricing.id,
      booking_date: 2.day.from_now,
      predicted_guests: 35,
      event_details: "details",
      event_adress: "some street 10",
      status: :confirmed
    )
    Rating.create!(
      client_id: client.id,
      buffet_id: buffet.id,
      value: 5,
      feedback: "muito legal"
    )
    #act
    travel 1.week
    login_as(client, scope: :client)
    visit buffet_path(buffet.id)
    #assert
    expect(page).not_to have_link "Avaliar Buffet"
  end
end
