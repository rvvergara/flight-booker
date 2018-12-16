class Airport < ApplicationRecord
  scope :distinct_airports, -> {select("distinct code")}
  scope :ascending_codes, -> {order("code")}
  has_many :departing_flights, foreign_key: :origin_id, class_name: "Flight"
  has_many :arriving_flights, foreign_key: :destination_id, class_name: "Flight"
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
end
