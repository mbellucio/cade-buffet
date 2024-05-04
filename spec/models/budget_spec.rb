require 'rails_helper'

RSpec.describe Budget, type: :model do
  context "#valid?" do
    describe "presence" do
      it "false when order_id is nil" do
        #arrange
        budget = Budget.new(order_id: "")
        #act
        budget.valid?
        #assert
        expect(budget.errors.include? :order_id).to be_truthy
      end

      it "false when payment_method_id is nil" do
        #arrange
        budget = Budget.new(payment_method_id: "")
        #act
        budget.valid?
        #assert
        expect(budget.errors.include? :payment_method_id).to be_truthy
      end

      it "false when proposal_deadline is nil" do
        #arrange
        budget = Budget.new(proposal_deadline: "")
        #act
        budget.valid?
        #assert
        expect(budget.errors.include? :proposal_deadline).to be_truthy
      end
    end

    describe "numericality" do
      it "false when base_price is not an integer" do
        #arrange
        budget = Budget.new(base_price: 2.2)
        #act
        budget.valid?
        #assert
        expect(budget.errors.include? :base_price).to be_truthy
      end

      it "false when additional_cost is not an integer" do
        #arrange
        budget = Budget.new(additional_cost: "a2")
        #act
        budget.valid?
        #assert
        expect(budget.errors.include? :additional_cost).to be_truthy
      end

      it "false when discout is not an integer" do
        #arrange
        budget = Budget.new(discount: 6.6)
        #act
        budget.valid?
        #assert
        expect(budget.errors.include? :discount).to be_truthy
      end

      it "false when final_price is not an integer" do
        #arrange
        budget = Budget.new(final_price: 6.6)
        #act
        budget.valid?
        #assert
        expect(budget.errors.include? :final_price).to be_truthy
      end
    end

    describe "date" do
      it "false when proposal_deadline date is not in the future" do
        #arrange
        budget = Budget.new(proposal_deadline: 1.day.ago)
        #act
        budget.valid?
        #assert
        expect(budget.errors.include? :proposal_deadline).to be_truthy
        expect(budget.errors[:proposal_deadline]).to include(" deve ser futura.")
      end

      it "false when proposal_deadline date is same day as today" do
        #arrange
        budget = Budget.new(proposal_deadline: Date.today)
        #act
        budget.valid?
        #assert
        expect(budget.errors.include? :proposal_deadline).to be_truthy
        expect(budget.errors[:proposal_deadline]).to include(" deve ser futura.")
      end
    end
  end
end
