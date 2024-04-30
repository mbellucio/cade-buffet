class PaymentMethod < ApplicationRecord
  has_many :buffet_payment_methods
  has_many :buffets, through: :buffet_payment_methods

  validates :method, presence: true
end
