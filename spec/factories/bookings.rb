FactoryBot.define do
  factory :booking do
    flight_id {Faker::Number.between(1,Flight.count)}

    after(:build) do |booking|
      passenger = Passenger.create(
        name: Faker::Name,
        email: Faker::Internet.email
      )
      booking.passengers.push(passenger)
    end
  end
end