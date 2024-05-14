require 'rails_helper'

describe 'Company edit event pricing' do
  it 'and fails if event pricing belongs to another company' do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    company_2 = Company.create!(
      buffet_name: "some Buffet 2",
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
    #act
    login_as(company_2, scope: :company_2)
    patch "/event_pricings/#{event_pricing.id}", :params => {:event_pricing => {
      :base_price => 2000,
      :extra_person_fee => 300,
      :extra_hour_fee => 200,
      :pricing_id => pricing.id,
      :event_id => event.id
    }}
    #assert
    expect(response).to redirect_to root_path
  end
end
