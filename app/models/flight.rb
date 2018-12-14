class Flight < ApplicationRecord
  scope :distinct_dates, -> {select("distinct start")}
  scope :ascending_dates, -> {order("start")}
  belongs_to :origin, class_name: "Airport"
  belongs_to :destination, class_name: "Airport"

  def self.origins
    joins(:origin).map {|flight| flight.origin.name}
  end

  def self.destinations
    joins(:destination).map {|flight| flight.destination.name}
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
