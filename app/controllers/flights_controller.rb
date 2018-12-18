class FlightsController < ApplicationController
  def index
    @airports = Airport.list
    @dates = Flight.dates
    
    if params[:origin] && params[:destination] && params[:date] && params[:passenger_count]
      @origin = Airport.find_by(code:params[:origin])
      @selected_origin = @origin.code
      @destination = Airport.find_by(code:params[:destination])
      @selected_destination = @destination.code
      @flights = Flight.search_flights(@origin.id, @destination.id, params[:date])
      @passenger_count = params[:passenger_count]
    end

   end

end
