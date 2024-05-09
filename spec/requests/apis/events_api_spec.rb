require 'rails_helper'

describe 'Event API' do
  context "GET  /api/v1/buffets/:buffet_id/events" do
    it "get events ordered by name successfully" do
      #arrange
      company = Company.create!(
        buffet_name: "some Buffet",
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
      Event.create!(
        name: "Festa Infantil",
        description: "muito legal!",
        min_quorum: 10,
        max_quorum: 50,
        standard_duration: 240,
        menu: "Cachorro quente e batata frita",
        serve_alcohol: false,
        handle_decoration: true,
        valet_service: false,
        flexible_location: true,
        buffet_id: buffet.id
      )
      Event.create!(
        name: "Churrasco",
        description: "muito bom",
        min_quorum: 20,
        max_quorum: 100,
        standard_duration: 240,
        menu: "Picanha",
        serve_alcohol: true,
        handle_decoration: false,
        valet_service: false,
        flexible_location: true,
        buffet_id: buffet.id
      )
      #act
      get "/api/v1/buffets/#{buffet.id}/events"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first["name"]).to eq "Churrasco"
      expect(json_response.first["description"]).to eq "muito bom"
      expect(json_response.first["min_quorum"]).to eq 20
      expect(json_response.first["max_quorum"]).to eq 100
      expect(json_response.first["standard_duration"]).to eq 240
      expect(json_response.first["menu"]).to eq "Picanha"
      expect(json_response.first["serve_alcohol"]).to eq true
      expect(json_response.first["handle_decoration"]).to eq false
      expect(json_response.first["valet_service"]).to eq false
      expect(json_response.first["flexible_location"]).to eq true

      expect(json_response.last["name"]).to eq "Festa Infantil"
    end

    it "Fails if buffet id not found" do
      #arrange

      #act
      get "/api/v1/buffets/999999999/events"
      #assert
      expect(response.status).to eq 404
    end
  end
end
