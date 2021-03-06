require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  before {
    controller_stub_token_authentication
  }

  let(:valid_session) { {} }


  describe "GET index" do
    let!(:trips) { create_list :trip, rand(2..10) }
    it "assigns all trips as @trips" do
      get :index, params: {}, session: valid_session
      expect(assigns(:trips).map(&:id)).to eq(trips.sort_by(&:id).map(&:id))
    end
  end

  describe "GET show" do
    let!(:trip) { create :trip }
    it "assigns the requested trip as @trip" do
      get :show, params: {:id => trip.to_param}, session: valid_session
      expect(assigns(:trip)).to eq(trip)
    end
  end

  describe "POST create" do
    let!(:time_window) { create :time_window }
    let!(:trip_kind) { create :trip_kind }
    let!(:trip) { create :trip }
    describe "with valid params" do
      it "creates a new Trip" do
        expect {
          post :create, params: {:trip_kind_id => trip_kind.to_param,
                                 :time_window_id => time_window.to_param}.merge(
              json_api_params(Trip, attributes_for(:trip).update(:trip_kind_id => trip_kind.to_param,
                                                                 :time_window_id => time_window.to_param)
              )), session: valid_session
        }.to change(Trip, :count).by(1)
      end

      it "assigns a newly created trip as @trip" do
        post :create, params: {:trip_kind_id => trip_kind.to_param, :time_window_id => time_window.to_param}.merge(
            json_api_params(Trip, attributes_for(:trip).update(:trip_kind_id => trip_kind.to_param,
                                                               :time_window_id => time_window.to_param)))
        expect(assigns(:trip)).to be_a(Trip)
        expect(assigns(:trip)).to be_persisted
      end
    end


    describe "with invalid params" do
      it "assigns a newly created but unsaved trip as @trip" do
        post :create, params: {:trip_kind_id => trip_kind.to_param, :time_window_id => time_window.to_param, :id =>
            trip.to_param}.merge(json_api_params(Trip, attributes_for(:trip).update(
            trip_kind_id: nil, order_id: nil, date: nil, time_window_id: nil))), session: valid_session
        expect(assigns(:trip)).to be_a_new(Trip)
      end
    end
  end


  describe "PUT update" do
    let!(:trip_kind) { create :trip_kind }
    let!(:time_window) { create :time_window }
    let!(:trip) { create :trip }
    let(:new_attributes) { attributes_for(:trip) }
    describe "with valid params" do
      it "updates the requested Trip" do
        put :update, params: {:trip_kind_id => trip_kind.to_param, :time_window_id => time_window.to_param, :id =>
            trip.to_param}.update(json_api_params(Trip, new_attributes).update(:trip_kind_id => trip_kind.to_param,
                                                                               :time_window_id => time_window.to_param)
        ), session: valid_session
        trip.reload
        new_attributes.except(:start_time,:end_time).each do |attr, val|
          expect(trip.send(attr)).to eq(val)
        end
        new_attributes.slice(:start_time,:end_time).each do |attr, val|
          expect(trip.send(attr).strftime('%H:%M')).to eq(val.strftime('%H:%M'))
        end
      end
    end


    it "assigns the requested trip as @trip" do
      put :update, params: {:trip_kind_id => trip_kind.to_param, :time_window_id => time_window.to_param, :id => trip.to_param
      }.update(json_api_params(Trip, new_attributes)), session: valid_session
      expect(assigns(:trip)).to eq(trip)
    end


    describe "with invalid params" do
      it "assigns the time_window as @trip" do
        put :update, params: {:trip_kind_id => trip_kind.to_param, :time_window_id => time_window.to_param, :id => trip.to_param
        }.update(
            json_api_params(Trip, new_attributes.update(trip_kind_id: nil, order_id: nil, date: nil, time_window_id: nil))), session: valid_session
        expect(assigns(:trip)).to eq(trip)
      end

    end
  end

  describe "DELETE destroy" do
    let!(:trip) { create :trip }
    it "destroys the requested trip" do
      expect {
        delete :destroy, params: {:id => trip.to_param}, session: valid_session
      }.to change(Trip, :count).by(-1)
    end
  end
end
