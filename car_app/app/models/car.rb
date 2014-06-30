class Car < ActiveRecord::Base
  validates :manufacturer_id, presence: true
  validates :color, presence: true
  validates :year, presence: true
  validates :mileage, presence: true

  belongs_to :manufacturer
end
