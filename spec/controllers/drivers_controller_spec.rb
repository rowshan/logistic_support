require 'rails_helper'

RSpec.describe DriversController, type: :controller do

  before {
    controller_stub_token_authentication
  }

  let(:valid_session) { {} }


  describe "GET index" do
    let!(:drivers) { create_list :driver, rand(2..10) }
    it "assigns all drivers as @drivers" do
      get :index, params: {}, session: valid_session
      expect(assigns(:drivers)).to eq(drivers)
    end
  end

  describe "GET show" do
    let!(:plant) { create :plant }
    let!(:driver) { create :driver }
    it "assigns the requested driver as @driver" do
      get :show, params: {:plant_id=>plant.to_param,:id => driver.to_param}, session: valid_session
      expect(assigns(:driver)).to eq(driver)
    end
  end

  describe "POST create" do
    let!(:plant) { create :plant }
    let!(:driver) { create :driver }

    describe "with valid params" do
      it "creates a new Driver" do
        expect {
          post :create, params:{:plant_id=> plant.to_param}.merge(json_api_params(
                                                                      Driver, attributes_for(:driver).update(
                                                                      :plant_id=> plant.to_param))
          ), session: valid_session
        }.to change(Driver, :count).by(1)
      end

      it "assigns a newly created driver as @driver" do
        post :create, params:{:plant_id=> plant.to_param}.merge(json_api_params(
                                                                    Driver, attributes_for(:driver).update(
                                                                    :plant_id=> plant.to_param))
        ), session: valid_session
        expect(assigns(:driver)).to be_a(Driver)
        expect(assigns(:driver)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved driver as @driver" do
        post :create, params:{:plant_id=> plant.to_param}.merge(json_api_params(
                                                                    Driver, attributes_for(:driver).update(
                                                                    first_name:nil,last_name:nil,enabled:nil))
        ), session: valid_session
        expect(assigns(:driver)).to be_a_new(Driver)
      end
    end
  end


  describe "PUT update" do
    let!(:driver) { create :driver  }
    let(:new_attributes) { attributes_for(:driver)}

    describe "with valid params" do
      it "updates the requested Driver" do
        put :update, params:{:plant_id=> driver.to_param,:id => driver.to_param}.update(json_api_params(Driver, new_attributes)
        ), session: valid_session
        driver.reload
        new_attributes.each do |attr, val|
          expect(driver.send(attr)).to eq(val)
        end
      end

      it "assigns the requested driver as @driver" do
        put :update, params: {:plant_id=> driver.to_param,:id => driver.to_param}.update(json_api_params(Driver, new_attributes)
        ), session: valid_session
        expect(assigns(:driver)).to eq(driver)
      end
    end

    describe "with invalid params" do
      it "assigns the driver as @driver" do
        put :update, params: {:plant_id=> driver.to_param,:id => driver.to_param}.update(
            json_api_params(Driver, new_attributes.update(  first_name:nil,last_name:nil,enabled:nil))),
            session: valid_session
        expect(assigns(:driver)).to eq(driver)
      end

    end
  end

  describe "DELETE destroy" do
    let!(:driver) { create :driver }
    it "destroys the requested driver" do
      expect {
        delete :destroy, params: {:id => driver.to_param}, session: valid_session
      }.to change(Driver, :count).by(-1)
    end
  end


end
