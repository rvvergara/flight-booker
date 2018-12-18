class FlightsController < ApplicationController
  def index
    @airports = Airport.list
    @dates = Flight.dates
    @title = "Home"
    if search_on?
      @origin = Airport.find_by(code:params[:origin])
      @selected_origin = @origin.code
      @destination = Airport.find_by(code:params[:destination])
      @selected_destination = @destination.code
      @flights = Flight.search_flights(@origin.id, @destination.id, params[:date])
      @passenger_count = params[:passenger_count]
      @selected_date = params[:date]
      @title = "Search Results"
    end

   end

end
