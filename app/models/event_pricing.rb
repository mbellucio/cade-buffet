class EventPricing < ApplicationRecord
  belongs_to :pricing
  belongs_to :event
end
