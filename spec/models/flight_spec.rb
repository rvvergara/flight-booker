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
    flight.flight_code = "STOLA"
    flight.valid?
    expect(flight.errors[:flight_code]).to include("has already been taken")
  end

  describe "distinct_dates scope and ascending dates scope" do
    it "returns list of distinct flight dates in ascending order" do
      flight1 = Flight.find(1)
      flight1 = Flight.find(2)
      flight1 = Flight.find(3)
      time = "00:00:00 UTC +00:00"
      expect(Flight.distinct_dates.count).to eql(4)
    end

    it "returns an ascending list of distinct flight dates" do
      expect(Flight.distinct_dates.ascending_dates[0].start).to eql(Flight.first.start)
    end
  end

  describe "Flight.origins" do
    it "returns a list of hashes containing flight origin for each flight_code" do
      flight1 = Flight.find(1)
      flight2 = Flight.find(2)
      flight3 = Flight.find(3)
      expect(Flight.origins).to eql(Flight.all.map{|flight| {flight.flight_code => flight.origin.name}})
    end
  end

  describe "Flight.destinations" do
    it "returns a list of hashes containing flight destinations for each flight_code" do
      flight1 = Flight.find(1)
      flight2 = Flight.find(2)
      flight3 = Flight.find(3)
      expect(Flight.destinations).to eql(Flight.all.map{|flight| {flight.flight_code => flight.destination.name}})
    end
  end

  describe "Flight.search_flights" do
    it "should return an empty array if no matching flights for given info" do
      expect(Flight.search_flights(3,1,"12-16-2018").blank?).to be(true)
    end

    it "should return matching flights for given info" do
      flight = Flight.first

      date_input = "#{flight.start.month}-#{flight.start.day}-#{flight.start.year}"
      
      expect(Flight.search_flights(flight.origin,flight.destination,date_input).blank?).to eql(false)
    end
  end

end
