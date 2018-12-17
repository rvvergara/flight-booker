Airport.create(
  code: "SFO",
  name: "San Francisco International Airport"
)

Airport.create(
  code: "LGA",
  name: "New York, La Guardia Airport"
)

Airport.create(
  code: "JFK",
  name: "New York, John F Kennedy International Airport"
)

Flight.create(
  origin_id: 1,
  destination_id: 2,
  start: Date.parse((Time.now + 5.days).to_s),
  duration: 7,
  flight_code: "STOLA"
)

Flight.create(
  origin_id: 1,
  destination_id: 3,
  start: Date.parse((Time.now + 20.days).to_s),
  duration: 7,
  flight_code: "STOJF"
)

Flight.create(
  origin_id: 3,
  destination_id: 2,
  start: Date.parse((Time.now + 15.days).to_s),
  duration: 7,
  flight_code: "JTOLA"
)

Flight.create(
  origin_id: 3,
  destination_id: 1,
  start: Date.parse((Time.now + 10.days).to_s),
  duration: 7,
  flight_code: "JTOSF"
)

4.times do |i|
  Booking.create(
    flight_id: i
  )
end

4.times do |i|
  Passenger.create(
    booking_id: i,
    name: Faker::Name.name,
    email: Faker::Internet.email
  )
end