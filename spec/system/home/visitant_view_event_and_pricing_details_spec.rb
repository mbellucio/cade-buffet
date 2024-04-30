require 'rails_helper'

describe 'Visitant view event and pricing details' do
  it 'sucessfully' do
    #arrange
    company = Company.create!(
      buffet_name: "some other Buffet",
      company_registration_number: "74.391.888/0001-97",
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
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing.id,
      base_price: 4000,
      extra_person_fee: 300,
      extra_hour_fee: 500
    )
    #act
    visit root_path
    within("div#buffet-#{buffet.id}") do
      click_on("Ver detalhes")
    end
    click_on "event1"
    #assert
    expect(page).to have_content "event1"
    expect(page).to have_content "Descrição do evento: muito legal!"
    expect(page).to have_content "Limite mínimo de pessoas: 10"
    expect(page).to have_content "Limite máximo de pessoas: 50"
    expect(page).to have_content "Duração padrão do evento (min): 240"
    expect(page).to have_content "Menu do evento: Cachorro quente e batata frita"
    expect(page).to have_content "Serve bebida alcoólica: Sim"
    expect(page).to have_content "Faz a decoração: Sim"
    expect(page).to have_content "Serviço de estacionamento/valet: Não"
    expect(page).to have_content "Realiza evento no local do contratante: Sim"

    expect(page).to have_content "Weekday"
    expect(page).to have_content "Preço base (10 pessoas): R$ 4.000,00"
    expect(page).to have_content "Adicional por pessoa: R$ 300,00"
    expect(page).to have_content "Adicional por hora extra de evento: R$ 500,00"
  end
end
