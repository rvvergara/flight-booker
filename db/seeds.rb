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
  start: Time.now + 5000,
  end: Time.now + 3500000
)