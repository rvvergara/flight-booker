FactoryBot.define do
  factory :airport do
    name "#{Faker::ParksAndRec.city} Airport"
    code {Faker::String.random(4)}
  end
end