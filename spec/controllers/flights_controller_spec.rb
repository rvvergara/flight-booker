require 'rails_helper'

RSpec.describe FlightsController do
  describe "GET #index" do
    
    context "without search results" do
      it "renders index template" do
        get :index 
        expect(response).to render_template(:index)
      end

      it "shows 2 dropdown lists of airports in descending order" do
        get :index
        expect(assigns(:airports)).to match_array(Airport.all.map {|a| a.code})
      end

      it "shows a dropdown of distinct flight dates" do
        get :index
        expect(assigns(:dates)).to match_array(Flight.all.map {|flight| flight.date_formatted})
      end
    end

    context "with search parameters" do
      it "gets the right airport based on the params[:origin]" do
        origin_code = Flight.first.origin.code
        destination_code = Flight.first.destination.code
        flight_date = Flight.first.date_formatted
        
        get :index, params: {
          origin: origin_code,
          destination: destination_code,
          date: flight_date
        }
        expect(assigns(:flights).map {|flight| flight.flight_code}).to match_array([Flight.first.flight_code])
      end
    end

  end
end
