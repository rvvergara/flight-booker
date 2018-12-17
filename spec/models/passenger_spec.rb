require 'rails_helper'

RSpec.describe Passenger do 

  describe "factories" do
    it "has a valid factory" do
      passenger = FactoryBot.build(:passenger)
      expect(passenger).to be_valid
    end
  end

  describe "validations" do
    passenger = FactoryBot.build(:passenger)
    
    it "is valid with name and email" do
      expect(passenger).to be_valid
    end

    it "is not valid without name" do
      passenger.name = nil
      passenger.valid?
      expect(passenger.errors[:name]).to include("can't be blank")
    end

    it "is not valid without email" do
      passenger.email = nil
      passenger.valid?
      expect(passenger.errors[:email]).to include("can't be blank")
    end

  end

end
