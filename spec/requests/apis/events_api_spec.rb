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
      expect(json_response.first["buffet"]["buffet_name"]).to eq "some Buffet"
      expect(json_response.first["buffet"]["id"]).to eq buffet.id

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

  context "GET /api/v1/events/id" do
    it "consults availability with success with guest number greater than the default of the event" do
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
      event = Event.create!(
        name: "Festa Infantil",
        description: "muito legal!",
        min_quorum: 30,
        max_quorum: 50,
        standard_duration: 240,
        menu: "Cachorro quente e batata frita",
        serve_alcohol: true,
        handle_decoration: true,
        valet_service: false,
        flexible_location: true,
        buffet_id: buffet.id
      )
      pricing_weekday = Pricing.create!(category: "Dias úteis")
      pricing_weekend = Pricing.create!(category: "Finais de semana e feriados")
      payment_method = PaymentMethod.create!(method: "PIX")
      BuffetPaymentMethod.create!(
        buffet_id: buffet.id,
        payment_method_id: payment_method.id,
      )
      EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekday.id,
        base_price: 4000,
        extra_person_fee: 300,
        extra_hour_fee: 500
      )
      EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekend.id,
        base_price: 5000,
        extra_person_fee: 400,
        extra_hour_fee: 700
      )
      #act
      get "/api/v1/events/#{event.id}", params: {booking_date: "2024-07-07", guest_number: "40"}
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response["event_id"]).to eq event.id
      expect(json_response["event"]).to eq "Festa Infantil"
      expect(json_response["estimated_price"]).to eq 9000
    end

    it "consults availability with success with guest number less or equal to the default of the event" do
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
      event = Event.create!(
        name: "Festa Infantil",
        description: "muito legal!",
        min_quorum: 30,
        max_quorum: 50,
        standard_duration: 240,
        menu: "Cachorro quente e batata frita",
        serve_alcohol: true,
        handle_decoration: true,
        valet_service: false,
        flexible_location: true,
        buffet_id: buffet.id
      )
      pricing_weekday = Pricing.create!(category: "Dias úteis")
      pricing_weekend = Pricing.create!(category: "Finais de semana e feriados")
      payment_method = PaymentMethod.create!(method: "PIX")
      BuffetPaymentMethod.create!(
        buffet_id: buffet.id,
        payment_method_id: payment_method.id,
      )
      EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekday.id,
        base_price: 4000,
        extra_person_fee: 300,
        extra_hour_fee: 500
      )
      EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekend.id,
        base_price: 5000,
        extra_person_fee: 400,
        extra_hour_fee: 700
      )
      #act
      get "/api/v1/events/#{event.id}", params: {booking_date: "2050-01-02", guest_number: "29"}
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response["event_id"]).to eq event.id
      expect(json_response["event"]).to eq "Festa Infantil"
      expect(json_response["estimated_price"]).to eq 5000
    end

    it "receive error if date is not future" do
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
      event = Event.create!(
        name: "Festa Infantil",
        description: "muito legal!",
        min_quorum: 30,
        max_quorum: 50,
        standard_duration: 240,
        menu: "Cachorro quente e batata frita",
        serve_alcohol: true,
        handle_decoration: true,
        valet_service: false,
        flexible_location: true,
        buffet_id: buffet.id
      )
      pricing_weekday = Pricing.create!(category: "Dias úteis")
      pricing_weekend = Pricing.create!(category: "Finais de semana e feriados")
      payment_method = PaymentMethod.create!(method: "PIX")
      BuffetPaymentMethod.create!(
        buffet_id: buffet.id,
        payment_method_id: payment_method.id,
      )
      EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekday.id,
        base_price: 4000,
        extra_person_fee: 300,
        extra_hour_fee: 500
      )
      EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekend.id,
        base_price: 5000,
        extra_person_fee: 400,
        extra_hour_fee: 700
      )
      #act
      get "/api/v1/events/#{event.id}", params: {booking_date: 1.day.ago, guest_number: "40"}
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq "A data deve ser futura"
    end

    it "receive error if date is not available" do
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
      event = Event.create!(
        name: "Festa Infantil",
        description: "muito legal!",
        min_quorum: 30,
        max_quorum: 50,
        standard_duration: 240,
        menu: "Cachorro quente e batata frita",
        serve_alcohol: true,
        handle_decoration: true,
        valet_service: false,
        flexible_location: true,
        buffet_id: buffet.id
      )
      pricing_weekday = Pricing.create!(category: "Dias úteis")
      pricing_weekend = Pricing.create!(category: "Finais de semana e feriados")
      payment_method = PaymentMethod.create!(method: "PIX")
      BuffetPaymentMethod.create!(
        buffet_id: buffet.id,
        payment_method_id: payment_method.id,
      )
      event_pricing = EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekday.id,
        base_price: 4000,
        extra_person_fee: 300,
        extra_hour_fee: 500
      )
      EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekend.id,
        base_price: 5000,
        extra_person_fee: 400,
        extra_hour_fee: 700
      )
      client = Client.create!(
        full_name: "Matheus Bellucio",
        social_security_number: "455.069.420-36",
        email: "matheus@gmail.com",
        password: "safestpasswordever"
      )
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return("AA44FF55")
      Order.create!(
        company_id: company.id,
        client_id: client.id,
        event_pricing_id: event_pricing.id,
        booking_date: 1.day.from_now,
        predicted_guests: 35,
        event_details: "details",
        event_adress: "some street 10",
        status: :awaiting
      )
      #act
      get "/api/v1/events/#{event.id}", params: {booking_date: 1.day.from_now, guest_number: "40"}
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq "Esta data está indisponível para este evento"
    end

    it "receive error if guest number is above permited by the event" do
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
      event = Event.create!(
        name: "Festa Infantil",
        description: "muito legal!",
        min_quorum: 30,
        max_quorum: 50,
        standard_duration: 240,
        menu: "Cachorro quente e batata frita",
        serve_alcohol: true,
        handle_decoration: true,
        valet_service: false,
        flexible_location: true,
        buffet_id: buffet.id
      )
      pricing_weekday = Pricing.create!(category: "Dias úteis")
      pricing_weekend = Pricing.create!(category: "Finais de semana e feriados")
      payment_method = PaymentMethod.create!(method: "PIX")
      BuffetPaymentMethod.create!(
        buffet_id: buffet.id,
        payment_method_id: payment_method.id,
      )
      EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekday.id,
        base_price: 4000,
        extra_person_fee: 300,
        extra_hour_fee: 500
      )
      EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekend.id,
        base_price: 5000,
        extra_person_fee: 400,
        extra_hour_fee: 700
      )
      #act
      get "/api/v1/events/#{event.id}", params: {booking_date: 1.day.from_now, guest_number: "400"}
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq "O número de convidados está acima do número máximo permitido pelo evento"
    end

    it "fails if invalid id" do
      #arrange

      #act
      get "/api/v1/events/9999999", params: {booking_date: 1.day.from_now, guest_number: "40"}
      #assert
      expect(response.status).to eq 404
    end

    it "and show only active events" do
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
        buffet_id: buffet.id,
        active: false
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
        buffet_id: buffet.id,
      )
      #act
      get "/api/v1/buffets/#{buffet.id}/events"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
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
      expect(json_response.first["buffet"]["buffet_name"]).to eq "some Buffet"
      expect(json_response.first["buffet"]["id"]).to eq buffet.id
    end

    it "receive error if date is within pricing category not covered by event" do
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
      event = Event.create!(
        name: "Festa Infantil",
        description: "muito legal!",
        min_quorum: 30,
        max_quorum: 50,
        standard_duration: 240,
        menu: "Cachorro quente e batata frita",
        serve_alcohol: true,
        handle_decoration: true,
        valet_service: false,
        flexible_location: true,
        buffet_id: buffet.id
      )
      pricing_weekday = Pricing.create!(category: "Dias úteis")
      payment_method = PaymentMethod.create!(method: "PIX")
      BuffetPaymentMethod.create!(
        buffet_id: buffet.id,
        payment_method_id: payment_method.id,
      )
      EventPricing.create!(
        event_id: event.id,
        pricing_id: pricing_weekday.id,
        base_price: 4000,
        extra_person_fee: 300,
        extra_hour_fee: 500
      )
      #act
      get "/api/v1/events/#{event.id}", params: {booking_date: "2050-01-02", guest_number: "40"}
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq "Este evento não é realizado neste período da semana"
    end
  end
end
