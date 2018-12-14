class Flight < ApplicationRecord
  belongs_to :origin, class_name: "Airport"
  belongs_to :destination, class_name: "Airport"

  def self.origins
    joins(:origin).map {|flight| flight.origin.name}
  end

  def self.destinations
    joins(:destination).map {|flight| flight.destination.name}
  end

  def date_formatted
    start.strftime("%m/%d/%Y")
  end

end
