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
    flight1 = Flight.find_by(id:1)
    flight1 = Flight.find_by(id:1)
    flight1 = Flight.find_by(id:3)

    context "dates class method" do
      
      it "returns an ascending list of distinct flight dates" do
        expect(Flight.dates).to match_array(Flight.find_by_sql("select distinct start from flights order by start").map {|flight| [flight.date_formatted_with_wkday, flight.date_formatted]})
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
  describe "associations with bookings and passengers" do
    flight = FactoryBot.build(:flight)

    booking1 = FactoryBot.build(:booking, flight_id: flight.id)

    booking2 = FactoryBot.build(:booking, flight_id: flight.id)

    it "shows how many passengers it has" do
      expect(flight.passengers.count).to eql(booking1.passengers.count + booking2.passengers.count)
    end
  end
end
