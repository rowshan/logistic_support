require 'rails_helper'

RSpec.describe "Plants", type: :request do
  before {
    controller_instance_stub_token_authentication(PlantsController)
  }

  let(:headers) {
    {}.merge(token_authentication).merge(json_api_headers)
  }



  describe "GET /plants" do
    let!(:plants) { create_list :plant, rand(5..10) }

    it 'responds with :ok' do
      get plants_path, headers: headers, as: :json
      expect(response).to have_http_status(:ok)
    end

    it 'responds with a list' do
      get plants_path, headers: headers, as: :json
      expect(json_api_response).to be_a(Array)
    end

    it 'responds with a correct list' do
      get plants_path, headers: headers, as: :json
      expect(json_api_response.size).to eq(plants.count)
      expect(plants.map(&:id)).to include(json_api_response.first['id'])
      expect(json_api_response.first['attributes']).to include('company','email','phone-no','address','tenant-id','url')
      expect(json_api_response.first['relationships']).to include('shifts','drivers')

    end
  end

  describe 'GET /plants/:id' do
    let!(:plant) { create :plant }

    describe 'for existing item' do
      it 'is a valid JSON API response' do
        get plant_path(plant), headers: headers, as: :json
        expect(response.body).to be_json_api_response_for(Plant)
      end
      it 'responds with the correct item' do
        get plant_path(plant), headers: headers, as: :json
        expect(json_api_response['id']).to eq(plant.id.to_s)
      end

      it 'responds with the correct information' do
        get plant_path(plant), headers: headers, as: :json
        expect(json_api_response['attributes']).to include('company','email','phone-no','address','tenant-id', 'url')
      end

      it 'responds with :ok' do
        get plant_path(plant), headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'for missing item' do
      it 'responds with :not_found' do
        get plant_path(-1000), headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /plants' do
    let!(:plant) { create :plant }
    describe 'with valid params' do
      it 'responds with :created' do
        _attrs = attributes_for(:plant).slice(:company,:email,:phone_no,:address,:tenant_id)
        post plants_path, params: json_api_params(Plant, _attrs), headers: headers, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    describe 'with invalid params' do
      it 'responds with :unprocessable_entity' do
        post plants_path, params: json_api_params(Plant, { company:nil,email:nil,phone_no:nil,address:nil,tenant_id:nil}
        ), headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /plants/:id' do
    let!(:plant) { create :plant }
    let(:new_attributes) { attributes_for(:plant) }

    describe 'with valid params' do

      it 'updates the requested Plant' do
        put plant_path(plant), params: json_api_params(Plant, new_attributes), headers: headers, as: :json
        plant.reload
        expect(plant.attributes.with_indifferent_access).to include(new_attributes)
      end

      it 'responds with :ok' do
        put plant_path(plant), params: json_api_params(Plant, new_attributes), headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'with invalid params' do
      it 'it responds with :unprocessable_entity' do
        put plant_path(plant), params: json_api_params(Plant, {company:nil,email:nil,phone_no:nil,
                                                               address:nil,tenant_id:nil}), headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'with missing item' do
      it 'responds with :not_found' do
        put plant_path(-1000), params: json_api_params(Plant, new_attributes), headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /plants/:id' do
    let!(:plant) { create :plant }

    it 'for existing item, responds with :no_content' do
      delete plant_path(plant), headers: headers, as: :json
      expect(response).to have_http_status(:no_content)
    end
    it 'for missing item, responds with :not_found' do
      delete plant_path(-1000), headers: headers, as: :json
      expect(response).to have_http_status(:not_found)
    end
  end
end
