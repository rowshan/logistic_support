require 'rails_helper'


RSpec.describe TripKindsController, type: :controller do

  before {
    controller_stub_token_authentication
  }

  let(:valid_session) { {} }

  describe "GET index" do
    let!(:trip_kinds) { create_list :trip_kind, rand(2..10) }
    it "assigns all trip_kinds as @trip_kinds" do
      get :index, parrams: {}, session: valid_session
      expect(assigns(:trip_kinds)).to eq(trip_kinds)
    end
  end

  describe "GET show" do
    let!(:trip_kind) { create :trip_kind }
    it "assigns the requested trip_kind as @trip_kind" do
      get :show, params: {:id => trip_kind.to_param}, session: valid_session
      expect(assigns(:trip_kind)).to eq(trip_kind)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TripKind" do
        expect {
          post :create, params: json_api_params(TripKind, attributes_for(:trip_kind)), session: valid_session
        }.to change(TripKind, :count).by(1)
      end

      it "assigns a newly created trip_kind as @trip_kind" do
        post :create, params: json_api_params(TripKind, attributes_for(:trip_kind)), session: valid_session
        expect(assigns(:trip_kind)).to be_a(TripKind)
        expect(assigns(:trip_kind)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved trip_kind as @trip_kind" do
        post :create, params: json_api_params(TripKind, attributes_for(:trip_kind).update(name: nil, description:nil)), session: valid_session
        expect(assigns(:trip_kind)).to be_a_new(TripKind)
      end
    end
  end


  describe "PUT update" do
    let!(:trip_kind) { create :trip_kind }
    let(:new_attributes) { attributes_for :trip_kind }
    describe "with valid params" do
      it "updates the requested TripKind" do
        put :update, params: {:id => trip_kind.to_param}.update(json_api_params(TripKind, new_attributes)), session: valid_session
        trip_kind.reload
        new_attributes.each do |attr, val|
          expect(trip_kind.send(attr)).to eq(val)
        end
      end

      it "assigns the requested trip_kind as @trip_kind" do
        put :update, params: {:id => trip_kind.to_param}.update(json_api_params(TripKind, new_attributes)), session: valid_session
        expect(assigns(:trip_kind)).to eq(trip_kind)
      end
    end

    describe "with invalid params" do
      it "assigns the trip_kind as @trip_kind" do
        put :update, params: {:id => trip_kind.to_param}.update(
            json_api_params(TripKind, new_attributes.update(name: nil, description:nil))), session: valid_session
        expect(assigns(:trip_kind)).to eq(trip_kind)
      end

    end
  end

  describe "DELETE destroy" do
    let!(:trip_kind) { create :trip_kind }
    it "destroys the requested trip_kind" do
      expect {
        delete :destroy, params: {:id => trip_kind.to_param}, session: valid_session
      }.to change(TripKind, :count).by(-1)
    end
  end
end
