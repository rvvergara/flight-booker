class FlightsController < ApplicationController
  def index
    @airports = Airport.all.map {|airport| airport.code}
    @dates = Flight.all.map {|flight| flight.start}
  end
end
