class FlightsController < ApplicationController
  def index
    @airports = Airport.distinct_airports.ascending_codes.map {|airport| airport.code}
    @dates = Flight.all.map {|flight| flight.date_formatted}

    @origin = Airport.find_by(code:params[:origin])
    @destination = Airport.find_by(code:params[:destination]) 
    @flights = Flight.search_flights(@origin.id, @destination.id, params[:date])

   end
end
