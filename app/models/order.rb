class Order < ApplicationRecord
  belongs_to :company
  belongs_to :client
  belongs_to :event_pricing
  has_one :budget
  has_many :messages

  enum status: {pending: 0, awaiting: 3, confirmed: 5, canceled: 9}

  before_validation :generate_code, on: :create

  validate :booking_date_is_future
  validate :predicted_guests_valid_range?
  validates(
    :company_id,
    :client_id,
    :event_pricing_id,
    :booking_date,
    :predicted_guests,
    :event_adress,
    presence: true
  )

  def calculate_budget
    client_guests = self.predicted_guests
    event_base_guest_number = self.event_pricing.event.min_quorum
    extra_person_fee = self.event_pricing.extra_person_fee

    if client_guests > event_base_guest_number
      extra = (client_guests - event_base_guest_number) * extra_person_fee
      return self.event_pricing.base_price + extra
    else
      return self.event_pricing.base_price
    end
  end

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def booking_date_is_future
    if self.booking_date.present? && self.booking_date <= Date.today
      self.errors.add(:booking_date, " deve ser futura.")
    end
  end

  def predicted_guests_valid_range?
    if self.predicted_guests.present? && self.predicted_guests > self.event_pricing.event.max_quorum
      self.errors.add(:predicted_guests, " deve ser menor ou igual ao máximo estipulado pelo evento")
    end
  end
end
