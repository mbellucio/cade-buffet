class Buffet < ApplicationRecord
  belongs_to :company
  accepts_nested_attributes_for :company

  validates :company_id, uniqueness: true
  validates(
    :company_name,
    :phone_number,
    :zip_code,
    :adress,
    :neighborhood,
    :city,
    :state_code,
    :description,
    presence: true
  )
  validates :state_code, length: {is:2}
end
