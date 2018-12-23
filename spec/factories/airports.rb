FactoryBot.define do
  factory :airport do
    name "#{Faker::GameOfThrones.city} Airport"
    code {Faker::String.random(4)}
  end
end