class FlightsController < ApplicationController
  def index
    @airports = Airport.list
    @dates = Flight.distinct_dates.ascending_dates.map {|flight| flight.date_formatted}
    
    if params[:origin] && params[:destination] && params[:date]
      @origin = Airport.find_by(code:params[:origin])
      @destination = Airport.find_by(code:params[:destination])
      @flights = Flight.search_flights(@origin.id, @destination.id, params[:date])
    end
    
   end

end
