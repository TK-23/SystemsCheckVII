class Manufacturer < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :country, presence: true

  has_many :cars
end
