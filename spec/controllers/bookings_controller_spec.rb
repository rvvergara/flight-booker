require 'rails_helper'

RSpec.describe BookingsController do

  describe "GET #show" do
    before :each do
    @booking = FactoryBot.create(:booking)
    @flight = @booking.flight
    @origin_airport = @flight.origin.name
    @destination_airport = @flight.destination.name
    passengers = @booking.passengers

    parameters = {params: {
      id: @booking.id.to_s
    }}

      get :show, parameters
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "assigns the booking corresponding to params[:id] to @booking" do
      expect(assigns(:booking)).to eq(@booking)
    end

    it "assigns to @flight what corresponds to @booking.flight" do
      expect(assigns(:flight)).to eq(@flight)
    end
  end

  describe "GET #new" do
    before :each do
      @flight = FactoryBot.create(:flight)
      @booking = FactoryBot.build(:booking, flight_id: @flight.id)
      @passenger_count = @booking.passengers.count
      parameters = {
        params: {
          booking: {
            chosen_flight: @flight.id,
            passengers: @passenger_count,
          }
        }
      }
      get :new, parameters
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the new bookings template" do
      expect(response).to render_template("new") 
    end

    it "assigns to @flight the chosen flight" do
      expect(assigns(:flight)).to eql(@flight)
    end

    it "assigns to @passenger_count the number of passengers in parameters" do
      expect(assigns(:passenger_count)).to eql(@passenger_count)
    end

    it "assigns @booking to a new instance of Booking" do
      expect(@booking).to be_a_new(Booking)
    end
    
    it "assigns each passenger to an instance of Passenger" do
      @booking.passengers.each do |passenger|
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

  describe "GET #edit" do
    before :each do
      @booking = FactoryBot.create(:booking)
      @flight = @booking.flight
      parameters = {params: {id: @booking.id}}
      get :edit, parameters
    end

    it "assigns requested booking to @booking" do
      expect(assigns(:booking)).to eq(@booking)
    end

    it "assigns the corresponding flight to @flight" do
      expect(assigns(:flight)).to eq(@flight)
    end

    it "renders the :edit template" do
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    before :each do
      @booking = FactoryBot.create(:booking)
      @flight = @booking.flight
      @passenger = @booking.passengers.first

      parameters = {params:{id: @booking.id, booking: FactoryBot.attributes_for(:booking, flight_id: @flight.id, passengers_attributes: [FactoryBot.attributes_for(:passenger, name: "Edward Peters")])}}

      patch :update, parameters
    end

    context "valid attributes" do
      it "locates requested @booking" do
        expect(assigns(:booking)).to eq(@booking)
      end

      # it "changes @booking's attributes" do
      #   @booking.reload
      #   # expect(@booking.passengers.first.name).to_not eq(@passenger.name)
      #   expect(@booking.passengers.count).to eq(1)
      # end

    end

  end

end
