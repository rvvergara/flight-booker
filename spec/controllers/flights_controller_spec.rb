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
        expect(assigns(:airports)).to match_array(Airport.all.map {|a| [a.name, a.code]})
      end

      it "shows a dropdown of distinct flight dates" do
        get :index
        expect(assigns(:dates)).to match_array(Flight.dates)
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
          passenger_count: 3,
          date: flight_date
        }
        
        expect(assigns(:flights)).to match_array(Flight.search_flights(Flight.first.origin_id, Flight.first.destination_id,flight_date))
      end
    end

  end
end
