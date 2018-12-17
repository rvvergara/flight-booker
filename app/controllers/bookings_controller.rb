class BookingsController < ApplicationController
  def new
    @flight = Flight.find_by(id: params[:booking][:chosen_flight])
    @passenger_count = params[:booking][:passengers].to_i
    @booking = Booking.new
  end
end
