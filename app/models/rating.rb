class Rating < ApplicationRecord
  belongs_to :buffet
  belongs_to :client

  has_one_attached :image

  validates(
    :value,
    :feedback,
    presence: true
  )

  validates :value, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
  }

end
