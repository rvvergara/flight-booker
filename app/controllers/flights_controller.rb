class FlightsController < ApplicationController
  def index
    @airports = Airport.distinct_airports.ascending_codes.map {|airport| airport.code}
    @dates = Flight.distinct_dates.ascending_dates.map {|flight| flight.date_formatted}
    
      @origin = Airport.find_by(code:params[:origin]) if params[:origin]
      @destination = Airport.find_by(code:params[:destination]) if params[:destination]
      @flights = Flight.search_flights(@origin.id, @destination.id, params[:date]) if params[:date]
   end
end
