require 'rails_helper'

RSpec.describe Flight do
  flight = Flight.new
  flight.origin_id = 2
  flight.destination_id = 1
  flight.start = Time.now + 200
  flight.end = flight.start + 30000
  
  it "should have start time" do
    flight.start = nil
    expect(flight).not_to be_valid
  end

  it "should have an end time" do
    flight.start = Time.now + 200
    flight.end = nil
    flight.destination_id = nil
    expect(flight).not_to be_valid
  end
end
