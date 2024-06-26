require 'rails_helper'

describe 'User register as company' do
  it 'with success' do
    #arrange

    #act
    visit root_path
    click_on "Empresas/Buffets"
    click_on "Registrar"
    fill_in "E-mail",	with: "bellucioalimentacao@gmail.com"
    fill_in "Nome do seu espaço", with: "Bellucio's Buffet"
    fill_in "Senha", with: "belluciobuffet2024"
    fill_in "Confirme sua senha", with: "belluciobuffet2024"
    fill_in "CNPJ", with: "74.391.888/0001-77"
    click_on "Enviar"
    #assert
    within("nav") do
      expect(page).to have_content("Bellucio's Buffet")
      expect(page).to have_content("Sair")
      expect(page).not_to have_content("Empresas/Buffets")
      expect(page).not_to have_content("Entrar")
    end
  end

  it "and logout" do
    #arrange
    #act
    visit root_path
    click_on "Empresas/Buffets"
    click_on "Registrar"
    fill_in "E-mail",	with: "bellucioalimentacao@gmail.com"
    fill_in "Nome do seu espaço", with: "Bellucio's Buffet"
    fill_in "Senha", with: "belluciobuffet2024"
    fill_in "Confirme sua senha", with: "belluciobuffet2024"
    fill_in "CNPJ", with: "74.391.888/0001-77"
    click_on "Enviar"
    within("nav") do
      click_on "Sair"
    end
    #assert
    within("nav") do
      expect(page).not_to have_content("Bellucio's Buffet")
      expect(page).not_to have_content("Sair")
      expect(page).to have_content("Empresas/Buffets")
      expect(page).to have_content("Entrar")
    end
  end

  it "and login" do
    #arrange
    Company.create!(
      buffet_name: "Bellucio's Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "bellucioalimentacao@gmail.com",
      password: "belluciobuffet2024"
    )
    #act
    visit root_path
    click_on "Empresas/Buffets"
    fill_in "E-mail",	with: "bellucioalimentacao@gmail.com"
    fill_in "Senha", with: "belluciobuffet2024"
    within("main#main form") do
      click_on "Entrar"
    end
    #assert
    within("nav") do
      expect(page).to have_content("Bellucio's Buffet")
      expect(page).to have_content("Sair")
      expect(page).not_to have_content("Empresas/Buffets")
      expect(page).not_to have_content("Entrar")
    end
  end

  it "and is redirected to buffet creation form" do
    #arrange
    company = Company.create!(
      buffet_name: "Bellucio's Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "bellucioalimentacao@gmail.com",
      password: "belluciobuffet2024"
    )
    #act
    login_as(company, :scope => :company)
    visit root_path
    #assert
    expect(current_path).to eq new_buffet_path
  end

  it "and only has acess to buffet creation route" do
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    #act
    login_as(company, :scope => :company)
    visit root_path
    within("nav") do
      click_on "Cadê Buffet"
    end
    #assert
    expect(current_path).to eq(new_buffet_path)
  end
end
