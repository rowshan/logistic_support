require 'rails_helper'

RSpec.describe PlantsController, type: :controller do
  before {
    controller_stub_token_authentication
  }

  let(:valid_session) { {} }
  let(:context) {
    OpenStruct.new(
        tenant_id: SecureRandom.uuid
    )
  }

  before {
    allow(controller).to receive(:current_context).and_return(context)
  }

  describe "GET index" do
    let!(:plants) { create_list :plant, rand(2..10), tenant_id: context.tenant_id }
    it "assigns all plants as @plants" do
      get :index, params: {}, session: valid_session
      expect(assigns(:plants).map(&:id)).to eq(plants.sort_by(&:id).map(&:id))
    end
  end

  describe "GET show" do
    let!(:plant) { create :plant, tenant_id: context.tenant_id }
    it "assigns the requested plant as @plant" do
      get :show, params: {:id => plant.to_param}, session: valid_session
      expect(assigns(:plant)).to eq(plant)
    end
  end

  describe "POST create" do
    let!(:plant) { create :plant }

    describe "with valid params" do
      it "creates a new Plant" do
        expect {
          post :create, params:{:id=> plant.to_param}.update(json_api_params(Plant, attributes_for(:plant))
          ), session: valid_session
        }.to change(Plant, :count).by(1)
      end

      it "assigns a newly created plant as @plant" do
        post :create, params:{:id=> plant.to_param}.update(json_api_params(Plant, attributes_for(:plant))
        ), session: valid_session
        expect(assigns(:plant)).to be_a(Plant)
        expect(assigns(:plant)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved plant as @plant" do
        post :create, params:{:id=> plant.to_param}.update(json_api_params(Plant, attributes_for(:plant).update(
            company:nil,email:nil,phone_no:nil,address:nil,tenant_id:nil))), session: valid_session
        expect(assigns(:plant)).to be_a_new(Plant)
      end
    end
  end


  describe "PUT update" do
    let!(:plant) { create :plant, tenant_id: context.tenant_id  }
    let(:new_attributes) { attributes_for(:plant).update(tenant_id: context.tenant_id)}

    describe "with valid params" do
      it "updates the requested Plant" do
        put :update, params:{:id => plant.to_param}.update(json_api_params(Plant, new_attributes)
        ), session: valid_session
        plant.reload
        new_attributes.each do |attr, val|
           expect(plant.send(attr)).to eq(val)
        end
      end

      it "assigns the requested plant as @plant" do
        put :update, params: {:id => plant.to_param}.update(json_api_params(Plant, new_attributes)
        ), session: valid_session
        expect(assigns(:plant)).to eq(plant)
      end
    end

    describe "with invalid params" do
      it "assigns the plant as @plant" do
        put :update, params: {:id => plant.to_param}.update(
            json_api_params(Plant, new_attributes.update( company:nil,email:nil,phone_no:nil,
                                                          address:nil,tenant_id:nil))), session: valid_session
        expect(assigns(:plant)).to eq(plant)
      end

    end
  end

  describe "DELETE destroy" do
    let!(:plant) { create :plant, tenant_id: context.tenant_id }
    it "destroys the requested plant" do
      expect {
        delete :destroy, params: {:id => plant.to_param}, session: valid_session
      }.to change(Plant, :count).by(-1)
    end
  end

end
