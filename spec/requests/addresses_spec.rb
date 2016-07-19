require 'rails_helper'

RSpec.describe "Addresses", type: :request do
    before {
      controller_instance_stub_token_authentication(AddressesController)
    }

    let(:headers) {
      {}.merge(token_authentication).merge(json_api_headers)
    }

    let(:real_addresses) {
      [{
           postal_code_id: SecureRandom.uuid, postal_code: %w(12435 14193 10711 10117).sample,
           city_id: SecureRandom.uuid, city: 'Berlin',
           province_id: SecureRandom.uuid, province: 'Berlin',
           country_id: SecureRandom.uuid, country_code: 'DE', country: 'Germany'
       },
       {
           postal_code_id: SecureRandom.uuid, postal_code: %w(80539 80802 80331 85356).sample,
           city_id: SecureRandom.uuid, city: 'Munich',
           province_id: SecureRandom.uuid, province: 'Bavaria',
           country_id: SecureRandom.uuid, country_code: 'DE', country: 'Germany'
       },
       {
           postal_code_id: SecureRandom.uuid, postal_code: %w(1010 1020 1060).sample,
           city_id: SecureRandom.uuid, city: 'Vienna',
           province_id: SecureRandom.uuid, province: 'Vienna',
           country_id: SecureRandom.uuid, country_code: 'AT', country: 'Austria'
       }
      ]
    }

    describe 'GET /trips/:trip_id/address' do
      let!(:address) { create :address }

      describe 'for existing item' do
        it 'is a valid JSON API response' do
          get trip_address_path(address.trip), headers: headers, as: :json
          expect(response.body).to be_json_api_response_for(Address)
        end
        it 'responds with the correct item' do
          get trip_address_path(address.trip), headers: headers, as: :json
          expect(json_api_response['id']).to eq(address.id.to_s)
        end

        it 'responds with the correct information' do
          get trip_address_path(address.trip), headers: headers, as: :json
          expect(json_api_response['attributes']).to include(
                                                         'salutation', 'first-name', 'last-name', 'street',
                                                         'house-no-main', 'house-no-add', 'other',
                                                         'postal-code', 'city', 'province', 'country-code',
                                                         'country', 'url')
        end

        it 'responds with :ok' do
          get trip_address_path(address.trip), headers: headers, as: :json
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'for missing item' do
        it 'responds with :not_found' do
          # NOTE: attn. this is raised by missing Trip, rather than Address
          get trip_address_path(-1000), headers: headers, as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe 'POST /trips/:trip_id/address' do
      let!(:trip) { create :trip }

      describe 'with valid params' do
        it 'responds with :created' do
          post trip_address_path(trip), params: json_api_params(Address, attributes_for(:address)), headers: headers, as: :json
          expect(response).to have_http_status(:created)
        end
      end

      describe 'with invalid params' do
        [ :first_name, :last_name,
          :street, :postal_code, :postal_code_id, :city, :city_id,
          :country, :country_code, :country_id ].each do |field|
          it "#{field}, responds with :unprocessable_entity" do
            post trip_address_path(trip), params: json_api_params(Address, attributes_for(:address).except(field)), headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end

    describe 'PUT /trips/:trip_id/address' do
      let!(:address) { create :address }
      let(:new_attributes) { attributes_for(:address) }

      describe 'with valid params' do

        it 'updates the requested address' do
          put trip_address_path(address.trip), params: json_api_params(Address, new_attributes), headers: headers, as: :json
          address.reload
          expect(address.attributes.with_indifferent_access).to include(new_attributes)
        end

        it 'responds with :ok' do
          put trip_address_path(address.trip), params: json_api_params(Address, new_attributes), headers: headers, as: :json
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'with invalid params' do
        [ :first_name, :last_name,
          :street, :postal_code, :postal_code_id, :city, :city_id,
          :country, :country_code, :country_id ].each do |field|
          it "#{field}, responds with :unprocessable_entity" do
            put trip_address_path(address.trip), params: json_api_params(Address, new_attributes.update(field => nil)), headers: headers, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      describe 'with missing item' do
        it 'responds with :not_found' do
          # NOTE: attn. this is raised by missing Trip, rather than Address
          put trip_address_path(-1000), params: json_api_params(Address, new_attributes), headers: headers, as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe 'DELETE /trips/:trip_id/address' do
      let!(:address) { create :address }

      it 'for existing item, responds with :no_content' do
        delete trip_address_path(address.trip), headers: headers, as: :json
        expect(response).to have_http_status(:no_content)
      end
      it 'for missing item, responds with :not_found' do
        # NOTE: attn. this is raised by missing Trip, rather than Address
        delete trip_address_path(-1000), headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
end
