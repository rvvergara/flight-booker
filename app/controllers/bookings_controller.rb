class BookingsController < ApplicationController
  def show
    @booking = Booking.find_by(id: params[:id])
    @flight = @booking.flight
    @origin_airport = @flight.origin.name
    @destination_airport = @flight.destination.name
    @passengers = @booking.passengers
  end
  def new
    @flight = Flight.find_by(id: params[:booking][:chosen_flight])
    @passenger_count = params[:booking][:passengers].to_i
    @booking = Booking.new
    @passenger = Passenger.new
    @passenger_count.times {@booking.passengers.new}
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to @booking
    else
      @flight = Flight.find_by(id: params[:booking][:flight_id])
      render "new"
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:name, :email])
  end
end
