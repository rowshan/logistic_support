require 'rails_helper'

RSpec.describe TimeWindowsController, type: :controller do

  before {
    controller_stub_token_authentication
  }

  let(:valid_session) { {} }

  describe "GET index" do
    let!(:time_windows) { create_list :time_window, rand(2..10)}
    it "assigns all time_windows as @time_windows" do
      get :index, parrams: {}, session: valid_session
      expect(assigns(:time_windows)).to eq(time_windows)
    end
  end

  describe "GET show" do
    let!(:time_window) { create :time_window }
    it "assigns the requested time_window as @time_window" do
      get :show, params: {:id => time_window.to_param}, session: valid_session
      expect(assigns(:time_window)).to eq(time_window)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TimeWindow" do
        expect {
          post :create, params: json_api_params(TimeWindow, attributes_for(:time_window)), session: valid_session
        }.to change(TimeWindow, :count).by(1)
      end

      it "assigns a newly created time_window as @time_window" do
        post :create, params: json_api_params(TimeWindow, attributes_for(:time_window)), session: valid_session
        expect(assigns(:time_window)).to be_a(TimeWindow)
        expect(assigns(:time_window)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved time_window as @time_window" do
        post :create, params: json_api_params(TimeWindow, attributes_for(:time_window).update(tenant_id: nil, start_time:nil, end_time:nil)), session: valid_session
        expect(assigns(:time_window)).to be_a_new(TimeWindow)
      end
    end
  end


  describe "PUT update" do
    let!(:time_window) { create :time_window }
    let(:new_attributes) { attributes_for :time_window }
    describe "with valid params" do
      it "updates the requested TimeWindow" do
        put :update, params: {:id => time_window.to_param}.update(json_api_params(TimeWindow, new_attributes)), session: valid_session
        time_window.reload
        new_attributes.each do |attr, val|
          expect(time_window.send(attr)).to eq(val)
        end
      end

      it "assigns the requested time_window as @time_window" do
        put :update, params: {:id => time_window.to_param}.update(json_api_params(TimeWindow, new_attributes)), session: valid_session
        expect(assigns(:time_window)).to eq(time_window)
      end
    end

    describe "with invalid params" do
      it "assigns the time_window as @time_window" do
        put :update, params: {:id => time_window.to_param}.update(
            json_api_params(TimeWindow, new_attributes.update(tenant_id: nil, start_time:nil, end_time:nil))), session: valid_session
        expect(assigns(:time_window)).to eq(time_window)
      end

    end
  end

  describe "DELETE destroy" do
    let!(:time_window) { create :time_window }
    it "destroys the requested time_window" do
      expect {
        delete :destroy, params: {:id => time_window.to_param}, session: valid_session
      }.to change(TimeWindow, :count).by(-1)
    end
  end

end
