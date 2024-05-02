require 'rails_helper'

RSpec.describe Order, type: :model do
  context "#valid?" do
    describe "presence" do
      it "false when company id is nil" do
        #arrange
        order = Order.new(company_id: "")
        #act
        order.valid?
        #assert
        expect(order.errors.include? :company_id).to be_truthy
      end

      it "false when client id is nil" do
        #arrange
        order = Order.new(client_id: "")
        #act
        order.valid?
        #assert
        expect(order.errors.include? :client_id).to be_truthy
      end

      it "false when event pricing id is nil" do
        #arrange
        order = Order.new(event_pricing_id: "")
        #act
        order.valid?
        #assert
        expect(order.errors.include? :event_pricing_id).to be_truthy
      end

      it "false when booking date is nil" do
        #arrange
        order = Order.new(booking_date: "")
        #act
        order.valid?
        #assert
        expect(order.errors.include? :booking_date).to be_truthy
      end

      it "false when predicted guests is nil" do
        #arrange
        order = Order.new(predicted_guests: "")
        #act
        order.valid?
        #assert
        expect(order.errors.include? :predicted_guests).to be_truthy
      end

      it "false when event adress is nil" do
        #arrange
        order = Order.new(event_adress: "")
        #act
        order.valid?
        #assert
        expect(order.errors.include? :event_adress).to be_truthy
      end
    end

    describe "date" do
      it "false when date is not in the future" do
        #arrange
        order = Order.new(booking_date: 1.day.ago)
        #act
        order.valid?
        #assert
        expect(order.errors.include? :booking_date).to be_truthy
        expect(order.errors[:booking_date]).to include(" deve ser futura.")
      end

      it "false when date is same day as today" do
        #arrange
        order = Order.new(booking_date: Date.today)
        #act
        order.valid?
        #assert
        expect(order.errors.include? :booking_date).to be_truthy
        expect(order.errors[:booking_date]).to include(" deve ser futura.")
      end
    end

    describe "random code" do
      it "generate random code upon order creation" do
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
        pricing_weekday = Pricing.create!(category: "Weekday")
        event_pricing = EventPricing.create!(
          event_id: event.id,
          pricing_id: pricing_weekday.id,
          base_price: 4000,
          extra_person_fee: 300,
          extra_hour_fee: 500
        )
        client = Client.create!(
          full_name: "Matheus Bellucio",
          social_security_number: "455.069.420-36",
          email: "matheus@gmail.com",
          password: "safestpasswordever"
        )
        order = Order.new(
          company_id: company.id,
          client_id: client.id,
          event_pricing_id: event_pricing.id,
          booking_date: 1.day.from_now,
          predicted_guests: 30,
          event_details: "details",
          event_adress: "some street 10",
          status: :pending
        )
        #act
        order.save!
        result = order.code
        #assert
        expect(result).not_to be_empty
        expect(result.length).to eq(8)
      end

      it "is unique" do
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
        pricing_weekday = Pricing.create!(category: "Weekday")
        event_pricing = EventPricing.create!(
          event_id: event.id,
          pricing_id: pricing_weekday.id,
          base_price: 4000,
          extra_person_fee: 300,
          extra_hour_fee: 500
        )
        client = Client.create!(
          full_name: "Matheus Bellucio",
          social_security_number: "455.069.420-36",
          email: "matheus@gmail.com",
          password: "safestpasswordever"
        )
        order_1 = Order.new(
          company_id: company.id,
          client_id: client.id,
          event_pricing_id: event_pricing.id,
          booking_date: 1.day.from_now,
          predicted_guests: 30,
          event_details: "details",
          event_adress: "some street 10",
          status: :pending
        )
        order_2 = Order.new(
          company_id: company.id,
          client_id: client.id,
          event_pricing_id: event_pricing.id,
          booking_date: 2.day.from_now,
          predicted_guests: 50,
          event_details: "details 2",
          event_adress: "some street 20",
          status: :pending
        )
        #act
        order_1.save!
        order_2.save!
        #assert
        expect(order_1.code).not_to eq(order_2.code)
      end
    end
  end
end
