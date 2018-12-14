require 'rails_helper'

RSpec.describe Airport, type: :model do
  airport = Airport.new
  airport.name = "My own airport"
  it "is not valid without a code" do
    expect(airport).not_to be_valid
  end

  it "is not valid without a name" do
    airport.code = "MYO"
    airport.name = ""
    expect(airport).not_to be_valid
  end

  it "is valid with complete information" do
    airport.name = "My Own Hangar"

    expect(airport).to be_valid
  end
end
