require 'rails_helper'

RSpec.describe Event, type: :model do
  context "#valid?" do
    describe "presence" do
      it "false when name is nil" do
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
        event = Event.new(
          name: "",
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
        #act
        #assert
        expect(event).not_to be_valid
      end

      it "false when description is nil" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "",
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
        #act
        #assert
        expect(event).not_to be_valid
      end

      it "false when minimum quorum is nil" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: "",
          max_quorum: 50,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        #act
        #assert
        expect(event).not_to be_valid
      end

      it "false when max quorum is nil" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: 10,
          max_quorum: "",
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        #act
        #assert
        expect(event).not_to be_valid
      end

      it "false when standard duration is nil" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: 10,
          max_quorum: 40,
          standard_duration: "",
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        #act
        #assert
        expect(event).not_to be_valid
      end

      it "false when standard duration is nil" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: 10,
          max_quorum: 40,
          standard_duration: "",
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        #act
        #assert
        expect(event).not_to be_valid
      end

      it "false when buffet_id is nil" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: 10,
          max_quorum: 40,
          standard_duration: 40,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
        )
        #act
        #assert
        expect(event).not_to be_valid
      end
    end

    describe "numericality" do
      it "false when minimum quorum not an integer" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: "dez",
          max_quorum: 40,
          standard_duration: 40,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        #act
        #assert
        expect(event).not_to be_valid
      end

      it "false when max quorum not an integer" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: 10,
          max_quorum: 1.5,
          standard_duration: 40,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        #act
        #assert
        expect(event).not_to be_valid
      end

      it "false when standard duration not an integer" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: 10,
          max_quorum: 50,
          standard_duration: 1.4,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        #act
        #assert
        expect(event).not_to be_valid
      end
    end

    describe "Comparison" do
      it "false when mininum quorum not greater than 0" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: 0,
          max_quorum: 50,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        #act
        #assert
        expect(event).not_to be_valid
      end

      it "false when maximum quorum not greater than 0" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: 1,
          max_quorum: 0,
          standard_duration: 240,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        #act
        #assert
        expect(event).not_to be_valid
      end

      it "false when standard duration not greater than 0" do
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
        event = Event.new(
          name: "Buffet 1000",
          description: "Descricao",
          min_quorum: 1,
          max_quorum: 1,
          standard_duration: 0,
          menu: "Cachorro quente e batata frita",
          serve_alcohol: false,
          handle_decoration: true,
          valet_service: false,
          flexible_location: true,
          buffet_id: buffet.id
        )
        #act
        #assert
        expect(event).not_to be_valid
      end
    end
  end
end
