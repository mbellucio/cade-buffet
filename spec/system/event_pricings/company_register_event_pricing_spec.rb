require 'rails_helper'

describe 'Company register event pricing' do
  it 'and access form from event details' do
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
    pricing = Pricing.create!(category: "Weekday")
    #act
    login_as(company)
    visit event_path(event.id)
    within("div#pricing-#{pricing.id}") do
      click_on "Configurar"
    end
    #assert
    expect(current_path).to eq(new_event_pricing_path)
    expect(page).to have_field "Preço base (10 pessoas)"
    expect(page).to have_field "Adicional por pessoa"
    expect(page).to have_field "Adicional por hora extra de evento"
    expect(page).to have_button "Enviar"
  end

  it "successfully" do
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
    #act
    login_as(company)
    visit event_path(event.id)
    within("div#pricing-#{pricing1.id}") do
      click_on "Configurar"
    end
    fill_in "Preço base (10 pessoas)", with: 2000
    fill_in "Adicional por pessoa", with: 200
    fill_in "Adicional por hora extra de evento", with: 300
    click_on "Enviar"
    #assert
    within("div#pricings") do
      expect(page).to have_content "Preço base (10 pessoas): R$ 2.000,00"
      expect(page).to have_content "Adicional por pessoa: R$ 200,00"
      expect(page).to have_content "Adicional por hora extra de evento: R$ 300,00"
      expect(page).to have_link "Editar"
    end
  end

  it "with empty fields" do
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
    pricing = Pricing.create!(category: "Weekday")
    #act
    login_as(company)
    visit event_path(event.id)
    within("div#pricing-#{pricing.id}") do
      click_on "Configurar"
    end
    fill_in "Preço base (10 pessoas)", with: ""
    fill_in "Adicional por pessoa", with: ""
    fill_in "Adicional por hora extra de evento", with: ""
    click_on "Enviar"
    #assert
    expect(page).to have_content "Preço base não pode ficar em branco"
    expect(page).to have_content "Adicional por pessoa não pode ficar em branco"
    expect(page).to have_content "Adicional por hora extra de evento não pode ficar em branco"
  end
end
