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
  start: Time.now + 5.days,
  duration: 7
)

Flight.create(
  origin_id: 1,
  destination_id: 3,
  start: Time.now + 20.days,
  duration: 7
)

Flight.create(
  origin_id: 3,
  destination_id: 2,
  start: Time.now + 15.days,
  duration: 7
)

Flight.create(
  origin_id: 3,
  destination_id: 1,
  start: Time.now + 10.days,
  duration: 7
)

