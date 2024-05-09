class EventPricing < ApplicationRecord
  belongs_to :pricing
  belongs_to :event

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

  def estimated_price(guests)
    if guests > self.event.max_quorum
      return false
    end

    if guests > self.event.min_quorum
      extra = (guests - self.event.max_quorum) * self.extra_person_fee
      return self.base_price + extra
    else
      return self.event_pricing.base_price
    end
  end
end
