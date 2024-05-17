require 'rails_helper'

RSpec.describe Rating, type: :model do
  context "#valid?" do
    describe "presence" do
      it "false when value is nil" do
        #arrange
        rating = Rating.new(value: "")
        #act
        rating.valid?
        #assert
        expect(rating.errors.include? :value).to be_truthy
      end

      it "false when feedback is nil" do
        #arrange
        rating = Rating.new(feedback: "")
        #act
        rating.valid?
        #assert
        expect(rating.errors.include? :feedback).to be_truthy
      end
    end

    describe "numericality" do
      it "false when less than 0" do
        #arrange
        rating = Rating.new(value: -1)
        #act
        rating.valid?
        #assert
        expect(rating.errors.include? :value).to be_truthy
      end

      it "false when greater than 5" do
        #arrange
        rating = Rating.new(value: 6)
        #act
        rating.valid?
        #assert
        expect(rating.errors.include? :value).to be_truthy
      end
    end
  end
end
