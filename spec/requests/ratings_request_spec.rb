require 'rails_helper'

describe 'Ratings request' do
  it 'fails to create if not authenticated as client' do
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
    client = Client.create!(
      full_name: "Matheus Bellucio",
      social_security_number: "455.069.420-36",
      email: "matheus@gmail.com",
      password: "safestpasswordever"
    )
    #act
    post "/buffets/#{buffet.id}/ratings", :params => { :rating => {
      :client_id => client.id,
      :buffet_id => buffet.id,
      :value => 5,
      :feedback => "very good",
    }}
    #assert
    expect(response).to redirect_to new_client_session_path
    expect(flash[:alert]).to eq 'Para continuar, faça login ou registre-se.'
  end

  it 'fails to create if client already rated buffet once' do
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
    client = Client.create!(
      full_name: "Matheus Bellucio",
      social_security_number: "455.069.420-36",
      email: "matheus@gmail.com",
      password: "safestpasswordever"
    )
    Rating.create!(
      client_id: client.id,
      buffet_id: buffet.id,
      value: 4,
      feedback: "muito legal 2"
    )
    #act
    login_as(client, scope: :client)
    post "/buffets/#{buffet.id}/ratings", :params => { :rating => {
      :client_id => client.id,
      :buffet_id => buffet.id,
      :value => 5,
      :feedback => "very good",
    }}
    #assert
    expect(response).to redirect_to root_path
    expect(flash[:alert]).to eq 'Você já avaliou este buffet.'
  end
end
