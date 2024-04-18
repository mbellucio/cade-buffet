require 'rails_helper'

RSpec.describe Buffet, type: :model do
  context "#valid?" do
    describe "uniqueness" do
      it "false when company_id already exists" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        Buffet.create!(
          email: "someemail@gmail.com",
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

        buffet = Buffet.new(
          email: "someemail2@gmail.com",
          payment_method: "pix, cc",
          company_name: "some company 2",
          phone_number: "1434324324",
          zip_code: "123123123",
          adress: "some street 2334",
          neighborhood: "some district 2",
          city: "some city 2",
          state_code: "NY",
          description: "An amazing buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when e-mail already exists" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        company2 = Company.create!(
          buffet_name: "some Buffet2",
          company_registration_number: "74.391.888/0001-66",
          email: "company3345@gmail.com",
          password: "safestpasswordever"
        )

        Buffet.create!(
          email: "someemail@gmail.com",
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

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "pix, cc",
          company_name: "some company 2",
          phone_number: "1434324324",
          zip_code: "123123123",
          adress: "some street 2334",
          neighborhood: "some district 2",
          city: "some city 2",
          state_code: "NY",
          description: "An amazing buffet",
          company_id: company2.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end
    end

    describe "presence" do
      it "false when company name is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "pix, cc",
          company_name: "",
          phone_number: "1434324324",
          zip_code: "123123123",
          adress: "some street 2334",
          neighborhood: "some district 2",
          city: "some city 2",
          state_code: "NY",
          description: "An amazing buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when phone number is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "",
          zip_code: "123123123",
          adress: "some street 2334",
          neighborhood: "some district 2",
          city: "some city 2",
          state_code: "NY",
          description: "An amazing buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when zip code is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "",
          adress: "some street 2334",
          neighborhood: "some district 2",
          city: "some city 2",
          state_code: "NY",
          description: "An amazing buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when adress is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "",
          neighborhood: "some district 2",
          city: "some city 2",
          state_code: "NY",
          description: "An amazing buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when neighborhood is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "some adress 1000",
          neighborhood: "",
          city: "some city 2",
          state_code: "NY",
          description: "An amazing buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when city is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "some adress 1000",
          neighborhood: "tijuca",
          city: "",
          state_code: "NY",
          description: "An amazing buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when state code is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "some adress 1000",
          neighborhood: "tijuca",
          city: "sdsadasd",
          state_code: "",
          description: "An amazing buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when description is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "some adress 1000",
          neighborhood: "tijuca",
          city: "sdsadasd",
          state_code: "RJ",
          description: "",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when company_id is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "some adress 1000",
          neighborhood: "tijuca",
          city: "sdsadasd",
          state_code: "RJ",
          description: "Some nice buffet",
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when email is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "some adress 1000",
          neighborhood: "tijuca",
          city: "sdsadasd",
          state_code: "RJ",
          description: "Some nice buffet",
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when payment method is nil" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail.com",
          payment_method: "",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "some adress 1000",
          neighborhood: "tijuca",
          city: "sdsadasd",
          state_code: "RJ",
          description: "Some nice buffet",
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end
    end

    describe "length" do
      it "false when state code lenght bigger than 2" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail,com",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "some adress 1000",
          neighborhood: "tijuca",
          city: "sdsadasd",
          state_code: "RJJ",
          description: "Some nice buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end

      it "false when state code lenght less than 2" do
        #arrange
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemail@gmail,com",
          payment_method: "pix, cc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "some adress 1000",
          neighborhood: "tijuca",
          city: "sdsadasd",
          state_code: "R",
          description: "Some nice buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end
    end

    describe "format" do
      it "false when email has wrong format" do
        company = Company.create!(
          buffet_name: "some Buffet",
          company_registration_number: "74.391.888/0001-77",
          email: "company@gmail.com",
          password: "safestpasswordever"
        )

        buffet = Buffet.new(
          email: "someemailgmailcom",
          payment_method: "pix, acc",
          company_name: "some name",
          phone_number: "123123123123",
          zip_code: "12313123123",
          adress: "some adress 1000",
          neighborhood: "tijuca",
          city: "sdsadasd",
          state_code: "RJ",
          description: "Some nice buffet",
          company_id: company.id
        )
        #act
        #assert
        expect(buffet).not_to be_valid
      end
    end
  end
end
