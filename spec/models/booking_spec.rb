require 'rails_helper'

RSpec.describe Booking do
  describe "factories" do
    it "has a valid factory" do
      expect(FactoryBot.build(:booking)).to be_valid
    end
  end

  describe "validations" do
    booking = FactoryBot.build(:booking)
    
    it "is valid with a flight_id" do
      expect(booking).to be_valid
    end

    it "is invalid without a flight_id" do
      booking.flight_id = nil
      booking.valid?
      expect(booking.errors[:flight_id]).to include("can't be blank")
    end
  end

end
