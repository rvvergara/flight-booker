FactoryBot.define do
  factory :booking do
    flight_id {Faker::Number.between(Flight.first.id, Flight.last.id)}

    after(:build) do |booking|
      1.times do
        passenger = booking.passengers.build(
          name: Faker::Name.name,
          email: Faker::Internet.email
        )
      end
    end
  end
end