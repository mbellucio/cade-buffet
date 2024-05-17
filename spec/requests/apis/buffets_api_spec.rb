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

  context "GET /api/v1/buffets/id" do
    it "get buffet details successfully" do
      #arrange
      company = Company.create!(
        buffet_name: "Jaquin",
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
      Rating.create!(
        client_id: client.id,
        buffet_id: buffet.id,
        value: 5,
        feedback: "muito legal"
      )
      Rating.create!(
        client_id: client_2.id,
        buffet_id: buffet.id,
        value: 3,
        feedback: "muito legal 2"
      )
      payment_method = PaymentMethod.create!(method: "PIX")
      payment_method_2 = PaymentMethod.create!(method: "Cartão de Crédito")
      BuffetPaymentMethod.create!(buffet_id: buffet.id, payment_method_id: payment_method.id)
      BuffetPaymentMethod.create!(buffet_id: buffet.id, payment_method_id: payment_method_2.id)
      #act
      get "/api/v1/buffets/#{buffet.id}"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)

      expect(json_response["buffet_name"]).to eq "Jaquin"
      expect(json_response["email"]).to eq "somecompany@gmail.com"
      expect(json_response["phone_number"]).to eq "112345556"
      expect(json_response["zip_code"]).to eq "123231231"
      expect(json_response["adress"]).to eq "some street 1000"
      expect(json_response["neighborhood"]).to eq "some district"
      expect(json_response["city"]).to eq "some city"
      expect(json_response["state_code"]).to eq "CA"
      expect(json_response["description"]).to eq "A nice buffet"
      expect(json_response["average_rating"]).to eq "4.0"

      expect(json_response["payment_methods"].length).to eq 2
      expect(json_response["payment_methods"].first["method"]).to eq "PIX"
      expect(json_response["payment_methods"].last["method"]).to eq "Cartão de Crédito"

      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
      expect(json_response.keys).not_to include("company_name")
      expect(json_response.keys).not_to include("company_registration_number")
      expect(json_response.keys).not_to include("company_id")
    end

    it "fails if buffet id not found" do
      #arrange

      #act
      get "/api/v1/buffets/9999999999"
      #assert
      expect(response.status).to eq 404
    end

    it "show only active buffets" do
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
        company_id: company_2.id,
        active: false
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
      expect(json_response.length).to eq 1
      expect(json_response.first["buffet_name"]).to eq "Jaquin"
      expect(json_response.first["state_code"]).to eq "CA"
    end
  end
end
