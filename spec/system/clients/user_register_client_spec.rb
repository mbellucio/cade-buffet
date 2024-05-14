require 'rails_helper'

describe 'User register as client' do
  it 'sucessfully' do
    #arrange
    #act
    visit root_path
    click_on "Entrar"
    click_on "Registrar"
    fill_in "Nome completo",	with: "Matheus Bellucio"
    fill_in "CPF",	with: "455.069.420-36"
    fill_in "E-mail",	with: "matheusbellucio@gmail.com"
    fill_in "Senha",	with: "safestpasswordever"
    fill_in "Confirme sua senha",	with: "safestpasswordever"
    click_on "Enviar"
    #assert
    within("nav") do
      expect(page).to have_content "Logado como: Matheus Bellucio"
      expect(page).to have_content "Sair"
    end
  end

  it "and login and logout" do
    #arrange
    Client.create!(
      full_name: "Matheus Bellucio",
      social_security_number: "455.069.420-36",
      email: "matheus@gmail.com",
      password: "safestpasswordever"
    )
    #act
    visit root_path
    click_on "Entrar"
    fill_in "E-mail", with: "matheus@gmail.com"
    fill_in "Senha", with: "safestpasswordever"
    within("main") do
      click_on "Entrar"
    end
    click_on "Sair"
    #assert
    within("nav") do
      expect(page).not_to have_content "Logado como: Matheus Bellucio"
      expect(page).not_to have_content "Sair"
      expect(page).to have_content("Empresas/Buffets")
      expect(page).to have_content("Entrar")
    end
  end

  it "with empty fields" do
    #arrange

    #act
    visit root_path
    click_on "Entrar"
    click_on "Registrar"
    fill_in "Nome completo",	with: ""
    fill_in "CPF",	with: ""
    fill_in "E-mail",	with: ""
    fill_in "Senha",	with: ""
    fill_in "Confirme sua senha",	with: ""
    click_on "Enviar"
    #assert
    within("main#main form") do
      expect(page).to have_content "E-mail não pode ficar em branco"
      expect(page).to have_content "Senha não pode ficar em branco"
      expect(page).to have_content "Nome completo não pode ficar em branco"
      expect(page).to have_content "CPF não pode ficar em branco"
      expect(page).to have_content "CPF tem que ser válido"
    end
  end
end
