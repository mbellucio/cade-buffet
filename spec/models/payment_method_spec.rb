require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  context "#valid?" do
    describe "presence" do
      it "false when method is nil" do
        #arrange
        payment_method = PaymentMethod.new(method: "")
        #act
        payment_method.valid?
        #assert
        expect(payment_method.errors.include? :method).to be_truthy
      end
    end
  end
end
