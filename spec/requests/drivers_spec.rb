require 'rails_helper'

RSpec.describe "Drivers", type: :request do
  before {
    controller_instance_stub_token_authentication(DriversController)
  }

  let(:headers) {
    {}.merge(token_authentication).merge(json_api_headers)
  }



  describe "GET /drivers" do
    let!(:drivers) { create_list :driver, rand(5..10) }

    it 'responds with :ok' do
      get drivers_path, headers: headers, as: :json
      expect(response).to have_http_status(:ok)
    end

    it 'responds with a list' do
      get drivers_path, headers: headers, as: :json
      expect(json_api_response).to be_a(Array)
    end

    it 'responds with a correct list' do
      get drivers_path, headers: headers, as: :json
      expect(json_api_response.size).to eq(drivers.count)
      expect(drivers.map(&:id)).to include(json_api_response.first['id'])
      expect(json_api_response.first['attributes']).to include('first-name','last-name','phone-no','plant-id','enabled','url')
      expect(json_api_response.first['relationships']).to include('plant')

    end
  end

  describe 'GET /drivers/:id' do
    let!(:driver) { create :driver }

    describe 'for existing item' do
      it 'is a valid JSON API response' do
        get driver_path(driver), headers: headers, as: :json
        expect(response.body).to be_json_api_response_for(Driver)
      end
      it 'responds with the correct item' do
        get driver_path(driver), headers: headers, as: :json
        expect(json_api_response['id']).to eq(driver.id.to_s)
      end

      it 'responds with the correct information' do
        get driver_path(driver), headers: headers, as: :json
        expect(json_api_response['attributes']).to include('first-name','last-name','phone-no','plant-id','enabled','url')
      end

      it 'responds with :ok' do
        get driver_path(driver), headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'for missing item' do
      it 'responds with :not_found' do
        get driver_path(-1000), headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /drivers' do
    let!(:driver) { create :driver }
    let!(:plant) { create :plant }

    describe 'with valid params' do
      it 'responds with :created' do
        _attrs = attributes_for(:driver).slice(:first_name,:last_name,:plant_id,:user_id,:enabled).update(
            :plant_id=> plant.to_param)
        post drivers_path, params: json_api_params(Driver, _attrs), headers: headers, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    describe 'with invalid params' do
      it 'responds with :unprocessable_entity' do
        post drivers_path, params: json_api_params(Driver, { first_name:nil,last_name:nil,plant_id:nil,enabled:nil}
        ), headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /drivers/:id' do
    let!(:driver) { create :driver }
    let(:new_attributes) { attributes_for(:driver) }

    describe 'with valid params' do

      it 'updates the requested Driver' do
        put driver_path(driver), params: json_api_params(Driver, new_attributes), headers: headers, as: :json
        driver.reload
        expect(driver.attributes.with_indifferent_access).to include(new_attributes)
      end

      it 'responds with :ok' do
        put driver_path(driver), params: json_api_params(Driver, new_attributes), headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'with invalid params' do
      it 'it responds with :unprocessable_entity' do
        put driver_path(driver), params: json_api_params(Driver, {first_name:nil,last_name:nil,plant_id:nil,
                                                                  enabled:nil}), headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'with missing item' do
      it 'responds with :not_found' do
        put driver_path(-1000), params: json_api_params(Driver, new_attributes), headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /drivers/:id' do
    let!(:driver) { create :driver }

    it 'for existing item, responds with :no_content' do
      delete driver_path(driver), headers: headers, as: :json
      expect(response).to have_http_status(:no_content)
    end
    it 'for missing item, responds with :not_found' do
      delete driver_path(-1000), headers: headers, as: :json
      expect(response).to have_http_status(:not_found)
    end
  end
end
