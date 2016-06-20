require 'rails_helper'

RSpec.describe AddressesController, type: :controller do

  before {
    controller_stub_token_authentication
  }

  let(:valid_session) { {} }

  describe "GET index" do
    let!(:trip) { create :trip }
    let!(:addresses) { create_list :address, rand(1..10)}
    it "assigns all addresses as @addresses" do
      get :index, params: {:trip_id=> address.trip.to_param}, session: valid_session
      expect(assigns(:addresses)).to eq(addresses)
      p (assigns(:address)).errors

    end
  end

  describe "GET show" do
    #let!(:trip) { create :trip }
    let!(:address) { create :address }
    it "assigns the requested address as @address" do
      get :show, params: {:trip_id=> trip.to_param,:id => address.to_param}, session: valid_session
      expect(assigns(:address)).to eq(address)
      p assigns(:address).errors
    end
  end

  #   describe "POST create" do
  #     let!(:trip) { create :trip }
  #
  #     describe "with valid params" do
  #       it "creates a new Address" do
  #         expect {
  #           post :create, params: {:trip_id => trip.to_param}.merge(
  #               json_api_params(Address, attributes_for(:address))), session: valid_session
  #         }.to change(Address, :count).by(1)
  #       end
  #
  #       it "assigns a newly created address as @address" do
  #         post :create, params: {:trip_id => trip.to_param}.merge(
  #             json_api_params(Address, attributes_for(:address))), session: valid_session
  #         expect(assigns(:address)).to be_a(Address)
  #         expect(assigns(:address)).to be_persisted
  #       end
  #     end
  #
  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved address as @address" do
  #       post :create, params: {:trip_id => trip.to_param}.merge(
  #           json_api_params(Address, attributes_for(:address).update(first_name: nil))), session: valid_session
  #       expect(assigns(:address)).to be_a_new(Address)
  #     end
  #   end
  # end
  # #
  #
  # describe "PUT update" do
  #   let!(:address) { create :address }
  #   let(:new_attributes) { attributes_for :address }
  #   describe "with valid params" do
  #     it "updates the requested Address" do
  #       put :update, params: {:id => address.to_param}.update(json_api_params(Address, new_attributes)), session: valid_session
  #       address.reload
  #       p address
  #       new_attributes.each do |attr, val|
  #         p attr,val
  #         expect(address.send(attr)).to eq(val)
  #       end
  #     end
  #
  #     it "assigns the requested address as @address" do
  #       put :update, params: {:id => address.to_param}.update(json_api_params(Address, new_attributes)), session: valid_session
  #       expect(assigns(:address)).to eq(address)
  #     end
  #   end
  #
  #   describe "with invalid params" do
  #     it "assigns the address as @address" do
  #       put :update, params: {:id => address.to_param}.update(
  #           json_api_params(Address, new_attributes.update(tenant_id: nil, start_time:nil, end_time:nil))), session: valid_session
  #       expect(assigns(:address)).to eq(address)
  #     end
  #
  #   end
  # end
  #
  # describe "DELETE destroy" do
  #   let!(:address) { create :address }
  #   it "destroys the requested address" do
  #     expect {
  #       delete :destroy, params: {:id => address.to_param}, session: valid_session
  #     }.to change(Address, :count).by(-1)
  #   end
  # end
end
