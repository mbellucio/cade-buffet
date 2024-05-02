class Order < ApplicationRecord
  belongs_to :company
  belongs_to :client
  belongs_to :event_pricing

  enum status: {pending: 0, confirmed: 5, canceled: 9}

  before_validation :generate_code

  validate :booking_date_is_future
  validates(
    :company_id,
    :client_id,
    :event_pricing_id,
    :booking_date,
    :predicted_guests,
    :event_adress,
    presence: true
  )

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def booking_date_is_future
    if self.booking_date.present? && self.booking_date <= Date.today
      self.errors.add(:booking_date, " deve ser futura.")
    end
  end
end
