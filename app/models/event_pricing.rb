class EventPricing < ApplicationRecord
  belongs_to :pricing
  belongs_to :event
  has_many :orders

  validates(
    :base_price,
    :extra_person_fee,
    :extra_hour_fee,
    presence: true
  )
  validates(
    :base_price,
    :extra_person_fee,
    :extra_hour_fee,
    numericality: { only_integer: true }
  )
end
