# Preview all emails at http://localhost:3000/rails/mailers/passenger_mailer
class PassengerMailerPreview < ActionMailer::Preview
  def new_passenger
    PassengerMailer.new_passenger(Passenger.last)
  end
end
