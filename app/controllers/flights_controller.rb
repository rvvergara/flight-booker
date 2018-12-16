class FlightsController < ApplicationController
  def index
    @airports = Airport.list
    @dates = Flight.dates
    
    if params[:origin] && params[:destination] && params[:date]
      @origin = Airport.find_by(code:params[:origin])
      @destination = Airport.find_by(code:params[:destination])
      @flights = Flight.search_flights(@origin.id, @destination.id, params[:date])
    end

   end

end
