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
    
    it "assigns each passenger to an instance of Passenger" do
      booking.passengers.each do |passenger|
        expect(passenger).to be_a_new(Passenger)
      end
    end
  end

  describe "POST #create" do
    before :each do
      @passengers = [
        FactoryBot.attributes_for(:passenger),
        FactoryBot.attributes_for(:passenger),
        FactoryBot.attributes_for(:passenger)
      ]
      @invalid_passengers = [
        FactoryBot.attributes_for(:invalid_passenger)
      ]
    end

    context "with valid attributes" do
      
      it "saves the new booking to the database" do
        expect{
          post :create, params:{booking: FactoryBot.attributes_for(:booking, passengers_attributes: @passengers)}}.to change(Booking, :count).by(1)
      end

      it "redirects to bookings#show" do
        post :create, params: {
          booking: FactoryBot.attributes_for(:booking, passengers_attributes: @passengers)
        }
        expect(response).to redirect_to booking_path(assigns[:booking])
      end
    end

    context "invalid attributes" do
    
      it "does not save new booking in the database" do
        expect{
          post :create, params:{booking: FactoryBot.attributes_for(:booking, passengers_attributes: @invalid_passengers)}
        }.to_not change(Booking, :count)
      end

      it "re-renders new template" do
        post :create, params: {
          booking: FactoryBot.attributes_for(:booking, passengers_attributes: @invalid_passengers)
        }
        expect(response).to render_template("new")
      end

    end

  end

end
