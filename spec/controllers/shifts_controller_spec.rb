require 'rails_helper'


RSpec.describe ShiftsController, type: :controller do
  before {
    controller_stub_token_authentication
  }

  let(:valid_session) { {} }


  describe "GET index" do
   let!(:shifts) { create_list :shift, rand(2..10), time_window: time_window, time_window_id: SecureRandom.uuid }
    it "assigns all shifts as @shifts" do
      get :index, parrams: {}, session: valid_session
      expect(assigns(:shifts)).to eq(shifts)
    end
  end

  describe "GET show" do
    let!(:shift) { create :shift }
    it "assigns the requested shift as @shift" do
      get :show, params: {:id => shift.to_param}, session: valid_session
      expect(assigns(:shift)).to eq(shift)
    end
  end

  describe "POST create" do
  let!(:shift) { create :shift}
  let!(:time_window) { create :time_window }

    describe "with valid params" do
      it "creates a new Shift" do
        expect {
          #post :create, params:json_api_params(Shift, attributes_for(:shift)), session: valid_session
         post :create, params:{:time_window_id=> shift.to_param}.update(json_api_params(Shift, attributes_for(:shift))), session: valid_session
        }.to change(Shift, :count).by(1)
      end

    #   it "assigns a newly created shift as @shift" do
    #    # post :create, params: json_api_params(Shift, attributes_for(:shift)), session: valid_session
    #     post :create, params:{:time_window_id=> time_window.shift.to_param}.update(json_api_params(Shift, attributes_for(:shift))), session: valid_session
    #     expect(assigns(:shift)).to be_a(Shift)
    #     p assigns(:shift).errors
    #     expect(assigns(:shift)).to be_persisted
    #   end
    # end
    #
    # describe "with invalid params" do
    #   it "assigns a newly created but unsaved shift as @shift" do
    #     #post :create, params:json_api_params(Shift, attributes_for(:shift)).update(time_window_id: nil, start_time:nil, end_time:nil,send_time:nil), session: valid_session
    #     post :create, params: {:time_window_id=> time_window.shift.to_param}.update(json_api_params(Shift, attributes_for(:shift)).update(time_window_id: nil,name:nil, start_time:nil, end_time:nil,send_time:nil)), session: valid_session
    #     expect(assigns(:shift)).to be_a_new(Shift)
    #     p assigns(:shift).errors
    #   end
     end
  end


  # describe "PUT update" do
  #   let!(:shift) { create :shift }
  #   let(:new_attributes) { attributes_for :shift }
  #   describe "with valid params" do
  #     it "updates the requested TimeWindow" do
  #       put :update, params: {:id => shift.to_param}.update(json_api_params(Shift, new_attributes)), session: valid_session
  #       shift.reload
  #       new_attributes.each do |attr, val|
  #         expect(shift.send(attr)).to eq(val)
  #       end
  #     end
  #
  #     it "assigns the requested shift as @shift" do
  #       put :update, params: {:id => shift.to_param}.update(json_api_params(Shift, new_attributes)), session: valid_session
  #       expect(assigns(:shift)).to eq(shift)
  #     end
  #   end
  #
  #   describe "with invalid params" do
  #     it "assigns the shift as @shift" do
  #       put :update, params: {:id => shift.to_param}.update(
  #           json_api_params(Shift, new_attributes.update(time_window_id: nil, start_time:nil, end_time:nil,send_time:nil))), session: valid_session
  #       expect(assigns(:shift)).to eq(shift)
  #     end
  #
  #   end
  # end
  #
  # describe "DELETE destroy" do
  #   let!(:shift) { create :shift }
  #   it "destroys the requested shift" do
  #     expect {
  #       delete :destroy, params: {:id => shift.to_param}, session: valid_session
  #     }.to change(Shift, :count).by(-1)
  #   end
  # end

end
