require 'rails_helper'

describe 'User register company' do
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
    expect(page).to have_content("Bem vindo! Você realizou seu registro com sucesso.")
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
    click_on "Sair"
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
    within("form") do
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
end
