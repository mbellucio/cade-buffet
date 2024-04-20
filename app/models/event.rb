class Event < ApplicationRecord
  belongs_to :buffet

  validates(
    :name,
    :description,
    :min_quorum,
    :max_quorum,
    :standard_duration,
    presence: true
  )
  validates(
    :min_quorum,
    :max_quorum,
    :standard_duration,
    numericality: { only_integer: true }
  )
  validates(
    :min_quorum,
    :max_quorum,
    :standard_duration,
    comparison: { greater_than: 0 }
  )

  def translate(bool)
    if bool
     return "Sim"
    end
    return "Não"
  end
end
