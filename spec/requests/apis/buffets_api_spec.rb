require 'rails_helper'

describe 'Buffet API' do
  context "GET /api/v1/buffets" do
    it "get all buffets in alphabetical order" do
      #arrange
      company = Company.create!(
        buffet_name: "Z Buffet",
        company_registration_number: "74.391.888/0001-77",
        email: "company@gmail.com",
        password: "safestpasswordever"
      )
      company_2 = Company.create!(
        buffet_name: "A Buffet",
        company_registration_number: "74.391.888/0001-88",
        email: "company2@gmail.com",
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
      buffet_2 = Buffet.create!(
        email: "somecompany2@gmail.com",
        company_name: "some company 2",
        phone_number: "11232354325",
        zip_code: "11232131231",
        adress: "some street 2000",
        neighborhood: "some district 2",
        city: "some city 2",
        state_code: "NY",
        description: "A nice buffet 2",
        company_id: company_2.id
      )
      payment_method = PaymentMethod.create!(method: "PIX")
      payment_method_2 = PaymentMethod.create!(method: "Cartão de Crédito")
      BuffetPaymentMethod.create!(buffet_id: buffet.id, payment_method_id: payment_method.id)
      BuffetPaymentMethod.create!(buffet_id: buffet_2.id, payment_method_id: payment_method_2.id)
      #act
      get "/api/v1/buffets"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first["buffet_name"]).to eq "A Buffet"
      expect(json_response.last["buffet_name"]).to eq "Z Buffet"
    end

    it "and search by buffet name" do
      #arrange
      company = Company.create!(
        buffet_name: "Jaquin",
        company_registration_number: "74.391.888/0001-77",
        email: "company@gmail.com",
        password: "safestpasswordever"
      )
      company_2 = Company.create!(
        buffet_name: "Attala",
        company_registration_number: "74.391.888/0001-88",
        email: "company2@gmail.com",
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
      buffet_2 = Buffet.create!(
        email: "somecompany2@gmail.com",
        company_name: "some company 2",
        phone_number: "11232354325",
        zip_code: "11232131231",
        adress: "some street 2000",
        neighborhood: "some district 2",
        city: "some city 2",
        state_code: "NY",
        description: "A nice buffet 2",
        company_id: company_2.id
      )
      payment_method = PaymentMethod.create!(method: "PIX")
      payment_method_2 = PaymentMethod.create!(method: "Cartão de Crédito")
      BuffetPaymentMethod.create!(buffet_id: buffet.id, payment_method_id: payment_method.id)
      BuffetPaymentMethod.create!(buffet_id: buffet_2.id, payment_method_id: payment_method_2.id)
      #act
      get "/api/v1/buffets", params: {search: "Jaquin"}
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response.first["buffet_name"]).to eq "Jaquin"
      expect(json_response.first["state_code"]).to eq "CA"
    end

    it "return empty if there is no buffet" do
      #arrange

      #act
      get "/api/v1/buffets"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
end
