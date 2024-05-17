class Rating < ApplicationRecord
  belongs_to :buffet
  belongs_to :client

  has_one_attached :image
end
