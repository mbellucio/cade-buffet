require 'rails_helper'

describe 'Visitant see average rating' do
  it 'from home page' do
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
    client_2 = Client.create!(
      full_name: "Jules",
      social_security_number: "925.506.760-50",
      email: "jules@gmail.com",
      password: "safestpasswordever"
    )
    client_3 = Client.create!(
      full_name: "Rafa",
      social_security_number: "679.504.770-91",
      email: "rafa@gmail.com",
      password: "safestpasswordever"
    )
    client_4 = Client.create!(
      full_name: "João",
      social_security_number: "885.581.220-32",
      email: "joao@gmail.com",
      password: "safestpasswordever"
    )
    Rating.create!(
      client_id: client.id,
      buffet_id: buffet.id,
      value: 5,
      feedback: "muito legal"
    )
    Rating.create!(
      client_id: client_2.id,
      buffet_id: buffet.id,
      value: 4,
      feedback: "muito legal 2"
    )
    Rating.create!(
      client_id: client_3.id,
      buffet_id: buffet.id,
      value: 3,
      feedback: "muito legal 3"
    )
    Rating.create!(
      client_id: client_4.id,
      buffet_id: buffet.id,
      value: 2,
      feedback: "muito legal 4"
    )
    #act
    visit root_path
    #assert
    within("div#buffet-#{buffet.id}") do
      expect(page).to have_content "3.5"
    end
  end

  it 'from buffet page' do
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
  client_2 = Client.create!(
    full_name: "Jules",
    social_security_number: "925.506.760-50",
    email: "jules@gmail.com",
    password: "safestpasswordever"
  )
  client_3 = Client.create!(
    full_name: "Rafa",
    social_security_number: "679.504.770-91",
    email: "rafa@gmail.com",
    password: "safestpasswordever"
  )
  client_4 = Client.create!(
    full_name: "João",
    social_security_number: "885.581.220-32",
    email: "joao@gmail.com",
    password: "safestpasswordever"
  )
  Rating.create!(
    client_id: client.id,
    buffet_id: buffet.id,
    value: 5,
    feedback: "muito legal"
  )
  Rating.create!(
    client_id: client_2.id,
    buffet_id: buffet.id,
    value: 4,
    feedback: "muito legal 2"
  )
  Rating.create!(
    client_id: client_3.id,
    buffet_id: buffet.id,
    value: 3,
    feedback: "muito legal 3"
  )
  Rating.create!(
    client_id: client_4.id,
    buffet_id: buffet.id,
    value: 2,
    feedback: "muito legal 4"
  )
  #act
  visit root_path
  #assert
  expect(page).to have_content "3.5"
 end
end
