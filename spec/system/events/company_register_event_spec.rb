require 'rails_helper'

describe 'Company register event' do
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
    #act
    login_as(company)
    visit new_event_path
    fill_in "Nome do evento",	with: "Churrasco"
    fill_in "Descrição do evento", with: "bem legal"
    fill_in "Quórum mínimo", with: 10
    fill_in "Quórum máximo", with: 50
    fill_in "Duração padrão do evento", with: 240
    fill_in "Menu do evento", with: "Picanha, maminha, baby beef"
    check("Serve bebida alcoólica")
    check("Faz a decoração")
    check("Serviço de estacionamento/valet")
    check("Realiza evento no local do contratante")
    click_on "Enviar"
    #assert
    within("div#event-details") do
      expect(page).to have_content("Churrasco")
      expect(page).to have_content("bem legal")
      expect(page).to have_content("10")
      expect(page).to have_content("50")
      expect(page).to have_content("240")
      expect(page).to have_content("Picanha, maminha, baby beef")
      expect(page).to have_content("Serve bebida alcoólica: Sim")
      expect(page).to have_content("Faz a decoração: Sim")
      expect(page).to have_content("Serviço de estacionamento/valet: Sim")
      expect(page).to have_content("Realiza evento no local do contratante: Sim")
      expect(page).to have_link("Voltar")
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
    #act
    login_as(company)
    visit new_event_path
    fill_in "Nome do evento",	with: ""
    fill_in "Descrição do evento", with: ""
    fill_in "Quórum mínimo", with: ""
    fill_in "Quórum máximo", with: ""
    fill_in "Duração padrão do evento", with: ""
    fill_in "Menu do evento", with: ""
    click_on "Enviar"
    #assert
    within("div#event-details") do
      expect(page).to have_content("Nome do evento não pode ficar em branco")
      expect(page).to have_content(" Descrição do evento não pode ficar em branco")
      expect(page).to have_content("Quórum mínimo não pode ficar em branco")
      expect(page).to have_content("Quórum máximo não pode ficar em branco")
      expect(page).to have_content("Duração padrão do evento (min) não pode ficar em branco")
      expect(page).to have_content("Quórum mínimo não é um número")
      expect(page).to have_content("Quórum máximo não é um número")
      expect(page).to have_content("Duração padrão do evento (min) não é um número")
      expect(page).to have_content("Quórum mínimo não pode ficar em branco")
      expect(page).to have_content("Quórum máximo não pode ficar em branco")
      expect(page).to have_content("Duração padrão do evento (min) não pode ficar em branco")
    end
  end
end
