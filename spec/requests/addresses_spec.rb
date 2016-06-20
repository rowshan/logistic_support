require 'rails_helper'

RSpec.describe "Addresses", type: :request do
    before {
      controller_instance_stub_token_authentication(AddressesController)
    }

    let(:headers) {
      {}.merge(token_authentication).merge(json_api_headers)
    }

    describe "GET /addresses" do
      let!(:addresses) { create_list :address, rand(5..10) }

      it 'responds with :ok' do
        get addresses_path, headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'responds with a list' do
        get addresses_path, headers: headers, as: :json
        expect(json_api_response).to be_a(Array)
      end

      it 'responds with a correct list' do
        get addresses_path, headers: headers, as: :json
        expect(json_api_response.size).to eq(addresses.count)
        expect(addresses.map(&:id)).to include(json_api_response.first['id'])
        expect(json_api_response.first['attributes']).to include('label', 'start-time', 'end-time', 'tenant-id', 'url')
        expect(json_api_response.first['relationships']).to include('shifts')

      end

    end
    #
    # describe 'GET /trips/:trip_id/addresses/:id' do
    #   let!(:address) { create :address }
    #
    #   describe 'for existing item' do
    #     it 'is a valid JSON API response' do
    #       get address_path(address), headers: headers, as: :json
    #       expect(response.body).to be_json_api_response_for(TimeWindow)
    #     end
    #     it 'responds with the correct item' do
    #       get address_path(address), headers: headers, as: :json
    #       expect(json_api_response['id']).to eq(time_window.id.to_s)
    #     end
    #
    #     it 'responds with the correct information' do
    #       get address_path(address), headers: headers, as: :json
    #       expect(json_api_response['attributes']).to include('label', 'start-time', 'end-time', 'tenant-id', 'url')
    #     end
    #
    #     it 'responds with :ok' do
    #       get address_path(address), headers: headers, as: :json
    #       expect(response).to have_http_status(:ok)
    #     end
    #   end
    #
    #   describe 'for missing item' do
    #     it 'responds with :not_found' do
    #       get time_window_path(-1000), headers: headers, as: :json
    #       expect(response).to have_http_status(:not_found)
    #     end
    #   end
    # end
    #
    # describe 'POST /trips/:trip_id/addresses' do
    #   describe 'with valid params' do
    #     it 'responds with :created' do
    #       _attrs = attributes_for(:address).slice( :tenant_id, :start_time, :end_time)
    #       post addresses_path, params: json_api_params(TimeWindow, _attrs), headers: headers, as: :json
    #       expect(response).to have_http_status(:created)
    #     end
    #   end
    #
    #   describe 'with invalid params' do
    #     it 'responds with :unprocessable_entity' do
    #       post addresses_path, params: json_api_params(TimeWindow, {tenant_id: nil,start_time:nil, end_time:nil}), headers: headers, as: :json
    #       expect(response).to have_http_status(:unprocessable_entity)
    #     end
    #   end
    # end
    #
    # describe 'PUT /trips/:trip_id/addresses/:id' do
    #   let!(:address) { create :address }
    #   let(:new_attributes) { attributes_for(:address).slice(:tenant_id, :start_time, :end_time) }
    #
    #   describe 'with valid params' do
    #
    #     it 'updates the requested address' do
    #       put address_path(address), params: json_api_params(TimeWindow, new_attributes), headers: headers, as: :json
    #       address.reload
    #       expect(address.attributes.with_indifferent_access).to include(new_attributes)
    #     end
    #
    #     it 'responds with :ok' do
    #       put address_path(time_window), params: json_api_params(TimeWindow, new_attributes), headers: headers, as: :json
    #       expect(response).to have_http_status(:ok)
    #     end
    #   end
    #
    #   describe 'with invalid params' do
    #     it 'it responds with :unprocessable_entity' do
    #       put address_path(time_window), params: json_api_params(TimeWindow, {tenant_id: nil,start_time:nil, end_time:nil}), headers: headers, as: :json
    #       expect(response).to have_http_status(:unprocessable_entity)
    #     end
    #   end
    #
    #   describe 'with missing item' do
    #     it 'responds with :not_found' do
    #       put address_path(-1000), params: json_api_params(TimeWindow, new_attributes), headers: headers, as: :json
    #       expect(response).to have_http_status(:not_found)
    #     end
    #   end
    # end
    #
    # describe 'DELETE /trips/:trip_id/addresses/:id' do
    #   let!(:address) { create :address }
    #
    #   it 'for existing item, responds with :no_content' do
    #     delete address_path(address), headers: headers, as: :json
    #     expect(response).to have_http_status(:no_content)
    #   end
    #   it 'for missing item, responds with :not_found' do
    #     delete address_path(-1000), headers: headers, as: :json
    #     expect(response).to have_http_status(:not_found)
    #   end
    # end
end
