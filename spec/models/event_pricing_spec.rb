require 'rails_helper'

RSpec.describe EventPricing, type: :model do
  context "#valid?" do
    describe "presence" do
      it "false when event id is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )
        buffet = Buffet.create!(
          email: "somecompany@gmail.com",
          payment_method: "pix, cc",
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
          name: "event1",
          description: "muito legal!",
          min_quorum: 10,
          max_quorum: 50,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: true,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        pricing = Pricing.create!(category: "Weekday")
        event_pricing = EventPricing.new(
          event_id: "",
          pricing_id: pricing.id,
          base_price: 4000,
          extra_person_fee: 300,
          extra_hour_fee: 500
        )
        #act
        #assert
        expect(event_pricing).not_to be_valid
      end

      it "false when pricing id is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )
        buffet = Buffet.create!(
          email: "somecompany@gmail.com",
          payment_method: "pix, cc",
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
          name: "event1",
          description: "muito legal!",
          min_quorum: 10,
          max_quorum: 50,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: true,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        pricing = Pricing.create!(category: "Weekday")
        event_pricing = EventPricing.new(
          event_id: event.id,
          pricing_id: "",
          base_price: 4000,
          extra_person_fee: 300,
          extra_hour_fee: 500
        )
        #act
        #assert
        expect(event_pricing).not_to be_valid
      end

      it "false when event base price is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )
        buffet = Buffet.create!(
          email: "somecompany@gmail.com",
          payment_method: "pix, cc",
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
          name: "event1",
          description: "muito legal!",
          min_quorum: 10,
          max_quorum: 50,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: true,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        pricing = Pricing.create!(category: "Weekday")
        event_pricing = EventPricing.new(
          event_id: event.id,
          pricing_id: pricing.id,
          base_price: "",
          extra_person_fee: 300,
          extra_hour_fee: 500
        )
        #act
        #assert
        expect(event_pricing).not_to be_valid
      end

      it "false when extra person fee is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )
        buffet = Buffet.create!(
          email: "somecompany@gmail.com",
          payment_method: "pix, cc",
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
          name: "event1",
          description: "muito legal!",
          min_quorum: 10,
          max_quorum: 50,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: true,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        pricing = Pricing.create!(category: "Weekday")
        event_pricing = EventPricing.new(
          event_id: event.id,
          pricing_id: pricing.id,
          base_price: 4000,
          extra_person_fee: "",
          extra_hour_fee: 500
        )
        #act
        #assert
        expect(event_pricing).not_to be_valid
      end

      it "false when extra hour fee is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )
        buffet = Buffet.create!(
          email: "somecompany@gmail.com",
          payment_method: "pix, cc",
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
          name: "event1",
          description: "muito legal!",
          min_quorum: 10,
          max_quorum: 50,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: true,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        pricing = Pricing.create!(category: "Weekday")
        event_pricing = EventPricing.new(
          event_id: event.id,
          pricing_id: pricing.id,
          base_price: 4000,
          extra_person_fee: 200,
          extra_hour_fee: ""
        )
        #act
        #assert
        expect(event_pricing).not_to be_valid
      end
    end

    describe "numericality" do
      it "false when base price not an integer" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )
        buffet = Buffet.create!(
          email: "somecompany@gmail.com",
          payment_method: "pix, cc",
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
          name: "event1",
          description: "muito legal!",
          min_quorum: 10,
          max_quorum: 50,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: true,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        pricing = Pricing.create!(category: "Weekday")
        event_pricing = EventPricing.new(
          event_id: event.id,
          pricing_id: pricing.id,
          base_price: "something",
          extra_person_fee: 200,
          extra_hour_fee: 500
        )
        #act
        #assert
        expect(event_pricing).not_to be_valid
      end

      it "false when extra person fee not an integer" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )
        buffet = Buffet.create!(
          email: "somecompany@gmail.com",
          payment_method: "pix, cc",
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
          name: "event1",
          description: "muito legal!",
          min_quorum: 10,
          max_quorum: 50,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: true,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        pricing = Pricing.create!(category: "Weekday")
        event_pricing = EventPricing.new(
          event_id: event.id,
          pricing_id: pricing.id,
          base_price: 2000,
          extra_person_fee: "a200",
          extra_hour_fee: 500
        )
        #act
        #assert
        expect(event_pricing).not_to be_valid
      end

      it "false when extra person fee not an integer" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )
        buffet = Buffet.create!(
          email: "somecompany@gmail.com",
          payment_method: "pix, cc",
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
          name: "event1",
          description: "muito legal!",
          min_quorum: 10,
          max_quorum: 50,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: true,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        pricing = Pricing.create!(category: "Weekday")
        event_pricing = EventPricing.new(
          event_id: event.id,
          pricing_id: pricing.id,
          base_price: 2000,
          extra_person_fee: 200,
          extra_hour_fee: "hjaskd"
        )
        #act
        #assert
        expect(event_pricing).not_to be_valid
      end
    end
  end
end
