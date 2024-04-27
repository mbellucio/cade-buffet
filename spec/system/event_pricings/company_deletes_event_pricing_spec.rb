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
      payment_method: "pix, cc",
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
end
