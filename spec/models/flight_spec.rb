require 'rails_helper'

RSpec.describe Flight do
  
  describe "factories" do
    it "has a valid factory" do
      expect(FactoryBot.build(:flight)).to be_valid
    end
  end

  describe "validations" do
    flight = FactoryBot.build(:flight)
    it "is valid with an origin_id, destination_id, start and duration" do
      flight.origin_id = 1
      flight.destination_id = 2
      flight.start = Date.today
      flight.duration = 2
      flight.flight_code = "PR101"

      expect(flight).to be_valid
    end

    it "is invalid without origin_id" do
      flight.origin_id = nil
      flight.valid?
      expect(flight.errors[:origin_id]).to include("can't be blank")
    end

    it "is invalid without destination_id" do
      flight.destination_id = nil
      flight.valid?
      expect(flight.errors[:destination_id]).to include("can't be blank")
    end

    it "is invalid without start" do
      flight.start = nil
      flight.valid?
      expect(flight.errors[:start]).to include("can't be blank")
    end

    it "is invalid without duration" do
      flight.duration = nil
      flight.valid?
      expect(flight.errors[:duration]).to include("can't be blank")
    end

    it "is invalid without flight_code" do
      flight.flight_code = nil
      flight.valid?
      expect(flight.errors[:flight_code]).to include("can't be blank")
    end

    it "is invalid with duplicate flight_code" do
      flight.flight_code = "STOLA"
      flight.valid?
      expect(flight.errors[:flight_code]).to include("has already been taken")
    end
  end

  describe "Flight class methods" do
    flight1 = Flight.find(1)
    flight1 = Flight.find(2)
    flight1 = Flight.find(3)

    context "distinct_dates scope and ascending dates scope" do
      
      it "returns list of distinct flight dates in ascending order" do  
        time = "00:00:00 UTC +00:00"
        expect(Flight.distinct_dates.count).to eql(4)
      end

      it "returns an ascending list of distinct flight dates" do
        expect(Flight.distinct_dates.ascending_dates[0].start).to eql(Flight.first.start)
      end
    end

    context "origins" do
      it "returns a list of hashes containing flight origin for each flight_code" do

        expect(Flight.origins).to eql(Flight.all.map{|flight| {flight.flight_code => flight.origin.name}})
      end
    end

    context "destinations" do
      it "returns a list of hashes containing flight destinations for each flight_code" do
        expect(Flight.destinations).to eql(Flight.all.map{|flight| {flight.flight_code => flight.destination.name}})
      end
    end

    context "search_flights" do
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
end
