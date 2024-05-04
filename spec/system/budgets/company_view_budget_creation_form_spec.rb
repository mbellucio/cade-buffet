require 'rails_helper'

describe 'company view budget creation form' do
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
    #assert
    expect(page).to have_content "Orçamento para o pedido: AA44FF55 - Festa Infantil"
    expect(page).to have_content "Categoria: Weekday"
    expect(page).to have_content "Preço base (30 pessoas): R$ 4.000,00"
    expect(page).to have_content "Adicional por convidado extra: R$ 300,00"
    expect(page).to have_content "Número de convidados: 35"
    expect(page).to have_content "Total parcial: R$ 5.500,00"
    within("main#main form") do
      expect(page).to have_field "Taxa extra"
      expect(page).to have_field "Razão da taxa extra"
      expect(page).to have_field "Desconto"
      expect(page).to have_field "Razão do desconto"
      expect(page).to have_field "Método de pagamento"
      expect(page).to have_field "Data limite do orçamento"
    end
  end
end
