class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, :social_security_number, presence: true
  validates :social_security_number, uniqueness: true
  validates :social_security_number, format: {
    with: /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/,
    message: "deve ser no formato xxx.xxx.xxx-xx"
  }
end
