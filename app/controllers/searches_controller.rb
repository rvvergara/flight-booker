class SearchesController < ApplicationController
  def index
    @origin = Airport.find_by(code:params[:airport][:origin])
    @destination = Airport.find_by(code:params[:airport][:destination]) 
    @flights = Flight.search_flights(@origin.id, @destination.id, params[:date])
  end
end
