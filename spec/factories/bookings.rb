FactoryBot.define do
  factory :booking do
    flight_id {Faker::Number.between(1,Flight.count)}

    after(:build) do |booking|
      2.times do
        passenger = booking.passengers.build(
          name: Faker::Name.name,
          email: Faker::Internet.email
        )
      end
    end
  end
end