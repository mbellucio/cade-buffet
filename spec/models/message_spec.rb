require 'rails_helper'

RSpec.describe Message, type: :model do
  context "#valid?" do
    describe "presence" do
      it "false when content is nil" do
        #arrange
        message = Message.new(content: "")
        #act
        message.valid?
        #assert
        expect(message.errors.include? :content).to be_truthy
      end
    end
  end
end
