FactoryBot.define do
  factory :passenger do
    association :booking
    name {Faker::Name.name}
    email {Faker::Internet.email}
  end
end