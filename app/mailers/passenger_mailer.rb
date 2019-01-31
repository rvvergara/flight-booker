class PassengerMailer < ApplicationMailer

  def new_passenger(passenger)
    @passenger = passenger
    @booking = @passenger.booking
    @flight = @booking.flight
    email_with_name = %("#{@passenger.name}" <#{@passenger.email}>)
    mail to: email_with_name, subject: "Booking for #{@flight.flight_code} details"
  end
end
