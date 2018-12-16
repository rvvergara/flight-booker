require 'rails_helper'

RSpec.describe Airport, type: :model do
  
  describe "validations" do
    airport = Airport.new
    it "is valid with a code and name" do
      airport.code = "LUM"
      airport.name = "Lumbia International Airport"
      expect(airport).to be_valid
    end
  
    it "is invalid without a code" do
      airport.code = nil
      airport.valid?
      expect(airport.errors[:code]).to include("can't be blank")
    end
  
    it "is invalid without a name" do
      airport.name = nil
      airport.valid?
      expect(airport.errors[:name]).to include("can't be blank")
    end
  
    it "is invalid with a duplicate code" do
      airport.code = "JFK"
      airport.valid?
      expect(airport.errors[:code]).to include("has already been taken")
    end  
  end

  describe "ascending_list class method" do
    it "returns an ascending list of airport codes" do
      expect(Airport.ascending_codes.map {|airport| airport.code}.first).to eql(Airport.all.map{|a| a.code}.sort.first)
    end
  end
end
