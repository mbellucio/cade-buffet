class Pricing < ApplicationRecord
  has_many :event_pricings
  has_many :events, through: :event_pricings
end
