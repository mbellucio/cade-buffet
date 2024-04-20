require 'rails_helper'

describe 'Company edits event' do
  it 'and see edit form' do
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
    #act
    login_as(company)
    visit event_path(event.id)
    click_on "Editar"
    #assert
    expect(page).to have_field "Descrição do evento"
    expect(page).to have_field "Quórum mínimo"
    expect(page).to have_field "Quórum máximo"
    expect(page).to have_field "Duração padrão do evento (min)"
    expect(page).to have_field "Menu do evento"
    expect(page).to have_field "Serve bebida alcoólica"
    expect(page).to have_field "Faz a decoração"
    expect(page).to have_field "Serviço de estacionamento/valet"
    expect(page).to have_field "Realiza evento no local do contratante"
  end

  it "with success" do
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
    #act
    login_as(company)
    visit edit_event_path(event.id)
    fill_in "Nome do evento",	with: "Evento 2"
    fill_in "Quórum mínimo", with: 20
    check("Serviço de estacionamento/valet")
    click_on "Atualizar Evento"
    #assert
    expect(current_path).to eq event_path(event.id)
    expect(page).to have_content "Evento atualizado com sucesso!"
    within("div#event-details") do
      expect(page).to have_content "Evento 2"
      expect(page).not_to have_content "event1"
      expect(page).to have_content "20"
      expect(page).to have_content "Serviço de estacionamento/valet: Sim"
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
    #act
    login_as(company)
    visit edit_event_path(event.id)
    fill_in "Nome do evento",	with: ""
    fill_in "Descrição do evento", with: ""
    fill_in "Quórum mínimo", with: ""
    fill_in "Quórum máximo", with: ""
    fill_in "Duração padrão do evento", with: ""
    fill_in "Menu do evento", with: ""
    click_on "Atualizar Evento"
    #assert
    expect(page).to have_content "Falha ao atualizar evento."
    expect(page).to have_content "Nome do evento não pode ficar em branco"
    expect(page).to have_content "Descrição do evento não pode ficar em branco"
    expect(page).to have_content "Quórum mínimo não pode ficar em branco"
    expect(page).to have_content "Quórum máximo não pode ficar em branco"
  end
end
