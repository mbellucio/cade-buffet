require 'rails_helper'

RSpec.describe Company, type: :model do
  context "#valid?" do
    describe "presence" do
      it "false when registration number is empty" do
        #arrange
        company = Company.new(
          email: "companysomething@gmail.com",
          password: "somesafepassword",
          buffet_name: "someRandomName"
        )
        #act
        #assert
        expect(company).not_to be_valid
      end

      it "false when buffet name is empty" do
        #arrange
        company = Company.new(
          email: "companysomething@gmail.com",
          password: "somesafepassword",
          company_registration_number: "asdasdas324234"
        )
        #act
        #assert
        expect(company).not_to be_valid
      end
    end

    describe "uniqueness" do
      it "false when registration number already exists" do
        #arrange
        Company.create!(
          buffet_name: "Some Buffet",
          company_registration_number: "07.144.417/0001-77",
          email: "companyemail@gmail.com",
          password: "somesafepassword"
        )
        company = Company.new(
          buffet_name: "Some other Buffet",
          company_registration_number: "07.144.417/0001-77",
          email: "buffet4life@gmail.com",
          password: "oliviarodrigo"
        )
        #act
        #assert
        expect(company).not_to be_valid
      end
    end
  end
end
