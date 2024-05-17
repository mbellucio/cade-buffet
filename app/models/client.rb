require "cpf_cnpj"

class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :messages, as: :user
  has_many :ratings

  validates :full_name, :social_security_number, presence: true
  validates :social_security_number, uniqueness: true
  validate :cpf_is_valid
  # validates :social_security_number, format: {
  #   with: /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/,
  #   message: "deve ser no formato xxx.xxx.xxx-xx"
  # }

  private
  def cpf_is_valid
    unless CPF.valid?(self.social_security_number)
      self.errors.add(:social_security_number, "tem que ser válido")
    end
  end
end
