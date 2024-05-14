require 'rails_helper'

RSpec.describe Client, type: :model do
  context "#valid?" do
    describe "presence" do
      it "false when full name is nil" do
        #arrange
        client = Client.new(full_name: "")
        #act
        client.valid?
        #assert
        expect(client.errors.include? :full_name).to be_truthy
      end

      it "false when social security number is nil" do
        #arrange
        client = Client.new(social_security_number: "")
        #act
        client.valid?
        #assert
        expect(client.errors.include? :social_security_number).to be_truthy
      end
    end

    describe "uniqueness" do
      it "Social Security number is unique" do
        #arrange
        Client.create!(
          full_name: "something",
          social_security_number: "455.069.420-36",
          email: "someemail@email.com",
          password: "123456"
        )
        client = Client.new(social_security_number: "455.069.420-36")
        #act
        client.valid?
        #assert
        expect(client.errors.include? :social_security_number).to be_truthy
      end
    end

    describe "format" do
      it "Social Security number is not valid" do
        #arrange
        client = Client.new(social_security_number: "111.111.111-1")
        client2 = Client.new(social_security_number: "111111111")
        client3 = Client.new(social_security_number: "111111111-11")
        #act
        client.valid?
        client2.valid?
        client3.valid?
        #assert
        expect(client.errors.include? :social_security_number).to be_truthy
        expect(client.errors[:social_security_number]).to include("tem que ser válido")
        expect(client2.errors.include? :social_security_number).to be_truthy
        expect(client3.errors.include? :social_security_number).to be_truthy
      end
    end
  end
end
