require 'rails_helper'

describe 'client register order' do
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
    pricing_weekend = Pricing.create!(category: "Weekend")
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing_weekday.id,
      base_price: 4000,
      extra_person_fee: 300,
      extra_hour_fee: 500
    )
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing_weekend.id,
      base_price: 7000,
      extra_person_fee: 400,
      extra_hour_fee: 900
    )
    client = Client.create!(
      full_name: "Matheus Bellucio",
      social_security_number: "455.069.420-36",
      email: "matheus@gmail.com",
      password: "safestpasswordever"
    )
    #act
    login_as(client, scope: :client)
    visit root_path
    within("div#buffet-#{buffet.id}") do
      click_on "Ver detalhes"
    end
    within("div#event") do
      click_on(event.name)
    end
    within("div#pricing-#{pricing_weekday.id}") do
      click_on "Contratar"
    end
    fill_in "Data do evento",	with: 1.day.from_now
    fill_in "Número de convidados", with: 30
    fill_in "Detalhes do evento", with: "Queremos também um crepeiro durante a festa."
    fill_in "Endereço do evento", with: "Rua Guimarães 20"
    click_on "Contratar serviço"
    #assert
    expect(page).to have_content "Pedido realizado com sucesso!"
    expect(page).to have_content "Buffet: Buffet Legal"
    expect(page).to have_content "Evento: Festa Infantil"
    expect(page).to have_content "Número de convidados: 30"
    expect(page).to have_content "Data do evento: #{1.day.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Local do evento: Rua Guimarães 20"
    expect(page).to have_content "Detalhes do evento: Queremos também um crepeiro durante a festa"
    expect(page).to have_content "Status do pedido: Aguardando avaliação do buffet"
  end

  it "with empty data" do
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
    pricing_weekend = Pricing.create!(category: "Weekend")
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing_weekday.id,
      base_price: 4000,
      extra_person_fee: 300,
      extra_hour_fee: 500
    )
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing_weekend.id,
      base_price: 7000,
      extra_person_fee: 400,
      extra_hour_fee: 900
    )
    client = Client.create!(
      full_name: "Matheus Bellucio",
      social_security_number: "455.069.420-36",
      email: "matheus@gmail.com",
      password: "safestpasswordever"
    )
    #act
    login_as(client, scope: :client)
    visit root_path
    within("div#buffet-#{buffet.id}") do
      click_on "Ver detalhes"
    end
    within("div#event") do
      click_on(event.name)
    end
    within("div#pricing-#{pricing_weekday.id}") do
      click_on "Contratar"
    end
    fill_in "Data do evento",	with: ""
    fill_in "Número de convidados", with: ""
    fill_in "Detalhes do evento", with: ""
    fill_in "Endereço do evento", with: ""
    click_on "Contratar serviço"
    #assert
    expect(page).to have_content "Data do evento não pode ficar em branco"
    expect(page).to have_content "Número de convidados não pode ficar em branco"
    expect(page).to have_content "Endereço do evento não pode ficar em branco"
  end

  it "cancels and go back" do
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
    pricing_weekend = Pricing.create!(category: "Weekend")
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing_weekday.id,
      base_price: 4000,
      extra_person_fee: 300,
      extra_hour_fee: 500
    )
    EventPricing.create!(
      event_id: event.id,
      pricing_id: pricing_weekend.id,
      base_price: 7000,
      extra_person_fee: 400,
      extra_hour_fee: 900
    )
    client = Client.create!(
      full_name: "Matheus Bellucio",
      social_security_number: "455.069.420-36",
      email: "matheus@gmail.com",
      password: "safestpasswordever"
    )
    #act
    login_as(client, scope: :client)
    visit root_path
    within("div#buffet-#{buffet.id}") do
      click_on "Ver detalhes"
    end
    within("div#event") do
      click_on(event.name)
    end
    within("div#pricing-#{pricing_weekday.id}") do
      click_on "Contratar"
    end
    click_on "Voltar"
    #assert
    expect(current_path).to eq event_path(event.id)
  end
end
