require 'rails_helper'

RSpec.describe Airport, type: :model do
  
  it "is valid with a code and name" do
    airport = Airport.new(
      code: "LUM",
      name: "Lumbia International Airport"
    )
    expect(airport).to be_valid
  end

  it "is invalid without a code" do
    airport = Airport.new(code: nil)
    airport.valid?
    expect(airport.errors[:code]).to include("can't be blank")
  end

  it "is invalid without a name" do
    airport = Airport.new(name: nil)
    airport.valid?
    expect(airport.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate code" do
    Airport.create(
      code: "BAC",
      name: "Bacolod International Airport"
    )
    airport = Airport.new(
      code: "BAC",
      name: "Mainland International"
    )
    airport.valid?
    expect(airport.errors[:code]).to include("has already been taken")
  end
  it "returns an ascending list of airport codes" do
    expect(Airport.ascending_codes.map {|airport| airport.code}).to eql(["BAC", "MNL"])
  end
end
