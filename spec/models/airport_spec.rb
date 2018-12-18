require 'rails_helper'

RSpec.describe Airport, type: :model do
  
  describe "factories" do
    it "has a valid factory" do
      expect(FactoryBot.build(:airport)).to be_valid
    end
  end

  describe "validations" do
    airport = FactoryBot.build(:airport)
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
      FactoryBot.create(:airport, code:"BAC", name:"Bacolod Airport")
      airport.code = "BAC"
      airport.valid?
      expect(airport.errors[:code]).to include("has already been taken")
    end  
  end

  describe "list class method" do
    it "returns an ascending list of distinct airport codes" do
      expect(Airport.list.first[1]).to eql(Airport.all.map{|a| a.code}.sort.first)
    end
  end
end
