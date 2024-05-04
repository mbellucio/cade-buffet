require 'rails_helper'

describe 'Company create budget' do
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return("AA44FF55")
    Order.create!(
      company_id: company.id,
      client_id: client.id,
      event_pricing_id: event_pricing.id,
      booking_date: 1.day.from_now,
      predicted_guests: 35,
      event_details: "details",
      event_adress: "some street 10",
      status: :pending
    )
    #act
    login_as(company, scope: :company)
    visit root_path
    click_on "Pedidos"
    click_on "Pedido: AA44FF55"
    click_on "Criar orçamento"
    fill_in "Taxa extra",	with: 1000
    fill_in "Razão da taxa extra",	with: "Locação de difícil acesso"
    fill_in "Desconto",	with: 200
    fill_in "Razão do desconto", with: "Equipamento clinário próprio"
    select "PIX", from: "Método de pagamento"
    fill_in "Data limite do orçamento", with: 1.day.from_now
    click_on "Enviar"
    #assert
    expect(page).to have_content("Preço base para 35 convidados: R$ 5.500,00")
    expect(page).to have_content("Taxa extra: R$ 1.000,00")
    expect(page).to have_content("Razão da taxa extra: Locação de difícil acesso")
    expect(page).to have_content("Desconto: R$ 200,00")
    expect(page).to have_content("Razão do desconto: Equipamento clinário próprio")
    expect(page).to have_content("Forma de pagamento: PIX")
    expect(page).to have_content("Total: R$ 6.300,00")
    expect(page).to have_content("Aguardando confirmação do cliente")
  end

  it "with empty data" do
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return("AA44FF55")
    Order.create!(
      company_id: company.id,
      client_id: client.id,
      event_pricing_id: event_pricing.id,
      booking_date: 1.day.from_now,
      predicted_guests: 35,
      event_details: "details",
      event_adress: "some street 10",
      status: :pending
    )
    #act
    login_as(company, scope: :company)
    visit root_path
    click_on "Pedidos"
    click_on "Pedido: AA44FF55"
    click_on "Criar orçamento"
    fill_in "Data limite do orçamento", with: ""
    click_on "Enviar"
    #assert
    expect(page).to have_content("Data limite do orçamento não pode ficar em branco")
  end

  it "Company cannot access budget creation page for another company" do
    #arrange
    company = Company.create!(
      buffet_name: "Buffet Legal",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    company_2 = Company.create!(
      buffet_name: "Buffet Legal 2",
      company_registration_number: "74.391.888/0001-55",
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
      company_id: company.id
    )
    Buffet.create!(
      email: "somecompany2@gmail.com",
      company_name: "some company2",
      phone_number: "11233422346",
      zip_code: "123234231231",
      adress: "some street 10002",
      neighborhood: "some district2",
      city: "some city2",
      state_code: "CA",
      description: "A nice buffet2",
      company_id: company_2.id
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return("AA44FF55")
    order = Order.create!(
      company_id: company.id,
      client_id: client.id,
      event_pricing_id: event_pricing.id,
      booking_date: 1.day.from_now,
      predicted_guests: 35,
      event_details: "details",
      event_adress: "some street 10",
      status: :pending
    )
    #act
    login_as(company_2, scope: :company_2)
    visit new_order_budget_path(order.id)
    #assert
    expect(current_path).not_to eq new_order_budget_path(order.id)
  end
end
