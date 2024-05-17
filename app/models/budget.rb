class Budget < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method

  validates(
    :order_id,
    :payment_method_id,
    :proposal_deadline,
    presence: true
  )

  validates(
    :base_price,
    :additional_cost,
    :discount,
    :final_price,
    numericality: { only_integer: true }
  )

  validate :proposal_deadline_is_future

  before_save :set_base_price, :calc_final_price

  def calc_final_price
    self.final_price = self.base_price + self.additional_cost - self.discount
  end

  def set_base_price
    self.base_price = self.order.calculate_budget
  end

  private
  def proposal_deadline_is_future
    if self.proposal_deadline.present? && self.proposal_deadline <= Date.today
      self.errors.add(:proposal_deadline, " deve ser futura.")
    end
  end
end
