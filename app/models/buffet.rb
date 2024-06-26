class Buffet < ApplicationRecord
  belongs_to :company
  accepts_nested_attributes_for :company
  has_many :events
  has_one_attached :cover
  has_many_attached :images
  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods
  has_many :ratings

  validates :company_id, :email, uniqueness: true
  validates :email, format:
    {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates(
    :company_name,
    :phone_number,
    :zip_code,
    :adress,
    :neighborhood,
    :city,
    :state_code,
    :description,
    :email,
    presence: true
  )
  validates :state_code, length: {is:2}
  # validate :at_least_one_buffet_payment_method

  def buffet_name
    self.company.buffet_name
  end

  def average_rating
    self.ratings.average(:value).round(1)
  end

end
