FactoryBot.define do
  factory :flight do
    origin_id {Faker::Number.between(1,Airport.count)}
    destination_id {Faker::Number.between(1,Airport.count)}
    start {Faker::Date.forward(100)}
    flight_code {Faker::String.random(6)}
    duration 7
  end
end