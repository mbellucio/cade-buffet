class Buffet < ApplicationRecord
  belongs_to :company
  accepts_nested_attributes_for :company
  has_many :events
  has_one_attached :cover
  has_many_attached :images

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
    :payment_method,
    presence: true
  )
  validates :state_code, length: {is:2}
end
