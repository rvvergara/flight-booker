require 'rails_helper'

RSpec.feature 'user visits the home page' do
  
  before :each do
    visit root_path
  end

  scenario 'users will see select box for flight origin' do
    expect(page).to have_select("origin")
  end

  scenario "users will see select box for flight destination" do
    expect(page).to have_select("destination")
  end

  scenario "user's choice of origin, destination and date corresponds to at least one existing flight" do
    select("San Francisco International", from:"origin")
    select("New York, La Guardia Airport", from:"destination")
    select("1", from:"passenger_count")
    select("Sunday December-23-2018", from:"date")
    click_on("Search Flights")

    within "ul" do
      expect(page).to have_content("STOLA")
      expect(page).to have_content("STOLA2")
    end
  end

  feature "user tries to search for flights" do
    before :each do
      select("San Francisco International", from:"origin")
      select("New York, La Guardia Airport", from:"destination")
      select("1", from:"passenger_count")
      select("Sunday December-23-2018", from:"date")
      click_on("Search Flights")
    end
    
    scenario "user's choice of origin, destination and date corresponds to at least one existing flight" do   
      within "ul" do
        expect(page).to have_content("STOLA")
        expect(page).to have_content("STOLA2")
        expect(page).to have_selector(:link_or_button, "Select Flight")
      end
    end

    scenario "user clicks on a flight to book" do
      first(:link_or_button, "Select Flight").click
      expect(page).to have_content("Booking Form")
    end
  end
end