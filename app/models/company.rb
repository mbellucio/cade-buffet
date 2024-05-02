class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :buffet
  has_many :orders

  validates :buffet_name, :company_registration_number, presence: true
  validates :company_registration_number, uniqueness: true
end
