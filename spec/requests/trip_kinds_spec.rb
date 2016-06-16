require 'rails_helper'

RSpec.describe "TripKinds", type: :request do
    before {
      controller_instance_stub_token_authentication(TripKindsController)
    }

    let(:headers) {
      {}.merge(token_authentication).merge(json_api_headers)
    }



    describe "GET /trip_kinds" do
      let!(:trip_kinds) { create_list :trip_kind, rand(5..10) }

      it 'responds with :ok' do
        get trip_kinds_path, headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'responds with a list' do
        get trip_kinds_path, headers: headers, as: :json
        expect(json_api_response).to be_a(Array)
      end

      it 'responds with a correct list' do
        get trip_kinds_path, headers: headers, as: :json
        expect(json_api_response.size).to eq(trip_kinds.count)
        expect(trip_kinds.map(&:id)).to include(json_api_response.first['id'])
        expect(json_api_response.first['attributes']).to include('name','description', 'url')
        expect(json_api_response.first['relationships']).to include('trips')

      end

    end

    describe 'GET /trip_kinds/:id' do
      let!(:trip_kind) { create :trip_kind }

      describe 'for existing item' do
        it 'is a valid JSON API response' do
          get trip_kind_path(trip_kind), headers: headers, as: :json
          expect(response.body).to be_json_api_response_for(TripKind)
        end
        it 'responds with the correct item' do
          get trip_kind_path(trip_kind), headers: headers, as: :json
          expect(json_api_response['id']).to eq(trip_kind.id.to_s)
        end

        it 'responds with the correct information' do
          get trip_kind_path(trip_kind), headers: headers, as: :json
          expect(json_api_response['attributes']).to include('name','description', 'url')
        end

        it 'responds with :ok' do
          get trip_kind_path(trip_kind), headers: headers, as: :json
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'for missing item' do
        it 'responds with :not_found' do
          get trip_kind_path(-1000), headers: headers, as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe 'POST /trip_kinds' do
      let!(:trip_kind) { create :trip_kind }
      describe 'with valid params' do
        it 'responds with :created' do
          _attrs = attributes_for(:trip_kind).slice(:name)
          post trip_kinds_path, params: json_api_params(TripKind, _attrs), headers: headers, as: :json
          expect(response).to have_http_status(:created)
        end
      end

      describe 'with invalid params' do
        it 'responds with :unprocessable_entity' do
          post trip_kinds_path, params: json_api_params(TripKind, { name: nil}), headers: headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'PUT /trip_kinds/:id' do
      let!(:trip_kind) { create :trip_kind }
      let(:new_attributes) { attributes_for(:trip_kind).slice(:name) }

      describe 'with valid params' do

        it 'updates the requested TripKind' do
          put trip_kind_path(trip_kind), params: json_api_params(TripKind, new_attributes), headers: headers, as: :json
          trip_kind.reload
          expect(trip_kind.attributes.with_indifferent_access).to include(new_attributes)
        end

        it 'responds with :ok' do
          put trip_kind_path(trip_kind), params: json_api_params(TripKind, new_attributes), headers: headers, as: :json
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'with invalid params' do
        it 'it responds with :unprocessable_entity' do
          put trip_kind_path(trip_kind), params: json_api_params(TripKind, {name: nil}), headers: headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      describe 'with missing item' do
        it 'responds with :not_found' do
          put trip_kind_path(-1000), params: json_api_params(TripKind, new_attributes), headers: headers, as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe 'DELETE /trip_kinds/:id' do
      let!(:trip_kind) { create :trip_kind }

      it 'for existing item, responds with :no_content' do
        delete trip_kind_path(trip_kind), headers: headers, as: :json
        expect(response).to have_http_status(:no_content)
      end
      it 'for missing item, responds with :not_found' do
        delete trip_kind_path(-1000), headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
end
