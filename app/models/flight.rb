class Flight < ApplicationRecord
  scope :distinct_dates, -> {select("distinct start")}
  scope :ascending_dates, -> {order("start")}
  has_many :bookings
  has_many :passengers, through: :bookings
  belongs_to :origin, class_name: "Airport"
  belongs_to :destination, class_name: "Airport"
  validates :origin_id, presence: true
  validates :destination_id, presence: true
  validates :start, presence: true
  validates :duration, presence: true
  validates :flight_code, presence: true, uniqueness: true

  def self.origins
    joins(:origin).map {|flight| {flight.flight_code => flight.origin.name}}
  end

  def self.destinations
    joins(:destination).map {|flight| {flight.flight_code => flight.destination.name}}
  end

  def Flight.dates
    distinct_dates.ascending_dates.map {|flight| flight.date_formatted }
  end

  def Flight.codes
    select("flight_code").map{|flight| flight.flight_code}
  end

  def date_formatted
    start.strftime("%m-%d-%Y")
  end

  def self.search_flights(origin, destination, start)
    Flight.where("origin_id = ? AND destination_id = ? AND start = ?", origin, destination, Date.strptime(start, "%m-%d-%Y"))
  end

  private
  def strip_time
    Date.strptime(start.to_s, "%m-%d-%Y").to_time
  end
end
