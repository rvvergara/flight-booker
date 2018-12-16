require 'rails_helper'

RSpec.describe Flight do

  it "is valid with an origin_id, destination_id, start and duration" do
    flight = Flight.new(
      origin_id: 1,
      destination_id: 2,
      start: Date.today,
      duration: 2,
      flight_code: "PR101"
    )
    expect(flight).to be_valid
  end

  it "is invalid without origin_id" do
    flight = Flight.new
    flight.origin_id = nil
    flight.valid?
    expect(flight.errors[:origin_id]).to include("can't be blank")
  end

  it "is invalid without destination_id" do
    flight = Flight.new
    flight.destination_id = nil
    flight.valid?
    expect(flight.errors[:destination_id]).to include("can't be blank")
  end

  it "is invalid without start" do
    flight = Flight.new
    flight.start = nil
    flight.valid?
    expect(flight.errors[:start]).to include("can't be blank")
  end

  it "is invalid without duration" do
    flight = Flight.new
    flight.duration = nil
    flight.valid?
    expect(flight.errors[:duration]).to include("can't be blank")
  end

  it "is invalid without flight_code" do
    flight = Flight.new
    flight.flight_code = nil
    flight.valid?
    expect(flight.errors[:flight_code]).to include("can't be blank")
  end

  it "is invalid with duplicate flight_code" do
    flight = Flight.new
    flight.flight_code = "MNLBAC"
    flight.valid?
    expect(flight.errors[:flight_code]).to include("has already been taken")
  end

  it "returns list of distinct flight dates in ascending order" do
    flight1 = Flight.create(
      origin_id: 1,
      destination_id: 2,
      start: Date.today,
      duration: 2,
      flight_code: "MNLBAC"
    )
    flight2 = Flight.create(
      origin_id: 2,
      destination_id: 1,
      start: Date.today + 2.days,
      duration: 2,
      flight_code: "BACMNL"
    )
    flight3 = Flight.create(
      origin_id: 1,
      destination_id: 2,
      start: Date.today + 2.days,
      duration: 2,
      flight_code: "MNLBAC2"
    )
    time = "00:00:00 UTC +00:00"
    expect(Flight.distinct_dates.count).to eql(2)
  end

  it "returns an ascending list of distinct flight dates" do
    expect(Flight.distinct_dates.ascending_dates[0].start).to eql(Flight.first.start)
  end

end
