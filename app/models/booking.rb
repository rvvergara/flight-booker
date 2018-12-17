class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers, dependent: :destroy
  accepts_nested_attributes_for :passengers, 
  allow_destroy: true
  validates :flight_id, presence: true
  validates_associated :passengers
end
