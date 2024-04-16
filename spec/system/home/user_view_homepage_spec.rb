require 'rails_helper'

describe 'User access homepage' do
  it 'and see app name' do
    #arrange

    #act
    visit root_path
    #assert
    within("nav") do
      expect(page).to have_content "Cadê Buffet"
    end
  end

  it "and see buffet register link" do
    #arrange

    #act
    visit root_path
    #assert
    within("nav") do
      expect(page).to have_content("Empresas/Buffets")
    end
  end

  it "and see login link" do
    #arrange

    #act
    visit root_path
    #assert
    within("nav") do
      expect(page).to have_content("Login")
    end
  end
end
