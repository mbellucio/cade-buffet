class Message < ApplicationRecord
  belongs_to :order
  belongs_to :user, polymorphic: true

  validates :content, presence: true
end
