require 'rails_helper'

RSpec.describe BookingsController do

  describe "GET #new" do
    flight = FactoryBot.create(:flight)
    booking = FactoryBot.build(:booking, flight_id: flight.id)
    passenger_count = booking.passengers.count
    parameters = {
      params: {
        booking: {
          chosen_flight: flight.id,
          passengers: passenger_count,
        }
      }
    }
    it "returns http success" do
      get :new, parameters
      expect(response).to have_http_status(:success)
    end

    it "renders the new bookings template" do
      get :new, parameters
      expect(response).to render_template("new") 
    end

    it "assigns to @flight the chosen flight" do
      get :new, parameters
      expect(assigns(:flight)).to eql(flight)
    end

    it "assigns to @passenger_count the number of passengers in parameters" do
      get :new, parameters
      expect(assigns(:passenger_count)).to eql(passenger_count)
    end

    it "assigns @booking to a new instance of Booking" do
      expect(booking).to be_a_new(Booking)
    end
    
  end

end
