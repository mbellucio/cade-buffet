require 'rails_helper'

describe 'Company edits buffet' do
  it 'and view the form' do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    Buffet.create!(
      email: "someemail@gmail.com",
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
    visit root_path
    click_on "Meu Buffet"
    click_on "Editar informações"
    #assert
    expect(page).to have_field("Nome fantasia")
    expect(page).to have_field("Razão social")
    expect(page).to have_content("CNPJ")
    expect(page).to have_field("E-mail")
    expect(page).to have_field("Telefone para contato")
    expect(page).to have_field("CEP")
    expect(page).to have_field("Bairro")
    expect(page).to have_field("Cidade")
    expect(page).to have_field("Estado")
    expect(page).to have_field("Métodos de pagamento aceitos")
    expect(page).to have_field("Descrição")
  end

  it "with success" do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    Buffet.create!(
      email: "someemail@gmail.com",
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
    visit root_path
    click_on "Meu Buffet"
    click_on "Editar informações"
    fill_in "Nome fantasia", with: "Tesla"
    fill_in "CEP", with: "20561-116"
    fill_in "Descrição", with: "Um buffet bem daora!"
    click_on "Enviar"
    #assert
    expect(page).to have_content "Buffet atualizado com sucesso!"
    expect(page).to have_content "Tesla"
    expect(page).to have_content "some company"
    expect(page).to have_content "74.391.888/0001-77"
    expect(page).to have_content "someemail@gmail.com"
    expect(page).to have_content "112345556"
    expect(page).to have_content "20561-116"
    expect(page).to have_content "some district"
    expect(page).to have_content "some city"
    expect(page).to have_content "CA"
    expect(page).to have_content "pix, cc"
    expect(page).to have_content "Um buffet bem daora!"
  end

  it "and cancel edition going back to view buffet" do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    buffet = Buffet.create!(
      email: "someemail@gmail.com",
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
    visit buffet_path(buffet.id)
    click_on "Editar informações"
    click_on "Voltar"
    #assert
    expect(current_path).to eq buffet_path(buffet.id)
  end
end
