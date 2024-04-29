require 'rails_helper'

describe 'Company register a buffet' do
  it 'with success' do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    #act
    login_as(company, :scope => :company)
    visit root_path
    fill_in "E-mail", with: "support@gmail.com"
    fill_in "Razão social", with: "buffet company 1000"
    fill_in "Telefone para contato", with: "40 98567-0045"
    fill_in "Endereço", with: "Rua 10"
    fill_in "Estado", with: "RJ"
    fill_in "Cidade", with: "Rio de Janeiro"
    fill_in "Bairro", with: "Tijuca"
    fill_in "CEP", with: "20561-116"
    fill_in "Métodos de pagamento aceitos", with: "pix, cc, cd"
    attach_file "Foto de exibição", Rails.root.join("spec", "support", "buffet_img.jpg")
    fill_in "Descrição", with: "Buffet de casamento"
    click_on "Enviar"

    #assert
    expect(page).to have_content("Buffet Cadastrado com sucesso!")
    expect(page).to have_content("some Buffet")
    expect(page).to have_content("buffet company 1000")
    expect(page).to have_content("Buffet de casamento")
    expect(page).to have_content("pix, cc, cd")
    expect(page).to have_content("support@gmail.com")
    expect(page).to have_css('img[src*="buffet_img.jpg"]')
  end

  it "with empty data" do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    #act
    login_as(company, :scope => :company)
    visit root_path
    fill_in "Razão social", with: ""
    fill_in "Telefone para contato", with: ""
    fill_in "Endereço", with: ""
    fill_in "Estado", with: ""
    fill_in "Cidade", with: ""
    fill_in "Bairro", with: ""
    fill_in "CEP", with: ""
    fill_in "Descrição", with: ""
    click_on "Enviar"
    #assert
    expect(page).to have_content "Cadastro não realizado"
    expect(page).to have_content "Telefone para contato não pode ficar em branco"
    expect(page).to have_content "CEP não pode ficar em branco"
    expect(page).to have_content "Endereço não pode ficar em branco"
    expect(page).to have_content "Bairro não pode ficar em branco"
    expect(page).to have_content "Cidade não pode ficar em branco"
    expect(page).to have_content "Estado não pode ficar em branco"
    expect(page).to have_content "Estado não possui o tamanho esperado (2 caracteres)"
    expect(page).to have_content "E-mail não pode ficar em branco"
    expect(page).to have_content "Métodos de pagamento aceitos não pode ficar em branco"
  end

  it "and can't access buffet creation page again" do
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
    login_as(company, :scope => :company)
    visit root_path
    visit new_buffet_path
    #assert
    expect(current_path).to eq(buffet_path(buffet.id))
  end
end
