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
    @passenger_count.times {@booking.passengers.new}
  end

  def edit
    @booking = Booking.find_by(id: params[:id])
    @flight = @booking.flight
  end

  def update
    @booking = Booking.find_by(id:params[:id])
    @passengers = @booking.passengers

    if @booking.update(booking_params)
      redirect_to @booking
    else
      @flight = Flight.find_by(id: @booking.flight.id)
      render "edit"
    end
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      @booking.passengers.each do |passenger|
        PassengerMailer.new_passenger(passenger).deliver_later
      end
      
      redirect_to @booking
    else
      @flight = Flight.find_by(id: params[:booking][:flight_id])
      render "new"
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:id,:name, :email])
  end
end
