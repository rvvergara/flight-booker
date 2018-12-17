FactoryBot.define do
  factory :booking do
    flight_id {Faker::Number.between(1,Flight.count)}
  end
end