require 'rails_helper'

RSpec.describe "Trips", type: :request do
    before {
      controller_instance_stub_token_authentication(TripsController)
    }

    let(:headers) {
      {}.merge(token_authentication).merge(json_api_headers)
    }

    describe "GET /trips" do
      let!(:trips) { create_list :trip, rand(5..10) }

      it 'responds with :ok' do
        get trips_path, headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'responds with a list' do
        get trips_path, headers: headers, as: :json
        expect(json_api_response).to be_a(Array)
      end

      it 'responds with a correct list' do
        get trips_path, headers: headers, as: :json
        expect(json_api_response.size).to eq(trips.count)
        expect(trips.map(&:id)).to include(json_api_response.first['id'])
        expect(json_api_response.first['attributes']).to include('trip-kind-id', 'order-id', 'date', 'time-window-id','address-id', 'url')
        expect(json_api_response.first['relationships']).to include('trip-kind','time-window')

      end

    end

    describe 'GET /trips/:id' do
      let!(:trip) { create :trip }

      describe 'for existing item' do
        it 'is a valid JSON API response' do
          get trip_path(trip), headers: headers, as: :json
          expect(response.body).to be_json_api_response_for(Trip)
        end
        it 'responds with the correct item' do
          get trip_path(trip), headers: headers, as: :json
          expect(json_api_response['id']).to eq(trip.id.to_s)
        end

        it 'responds with the correct information' do
          get trip_path(trip), headers: headers, as: :json
          expect(json_api_response['attributes']).to include('trip-kind-id', 'order-id', 'date', 'time-window-id','address-id', 'url')
        end

        it 'responds with :ok' do
          get trip_path(trip), headers: headers, as: :json
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'for missing item' do
        it 'responds with :not_found' do
          get trip_path(-1000), headers: headers, as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe 'POST /trips' do
      describe 'with valid params' do
        # let!(:trip_kind) { create :trip_kind }
        # let!(:time_window) { create :time_window }

        it 'responds with :created' do
          _attrs = attributes_for(:trip).slice(:order_id,:address_id,:date)
          post trips_path, params: json_api_params(Trip, _attrs), headers: headers, as: :json
          expect(response).to have_http_status(:created)
        end
      end

      describe 'with invalid params' do
        it 'responds with :unprocessable_entity' do
          post trips_path, params: json_api_params(Trip, {trip_kind_id: nil, order_id: nil, date: nil, time_window_id: nil, address_id: nil}), headers: headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    #
    # describe 'PUT /trips/:id' do
    #   let!(:trip) { create :trip }
    #   let(:new_attributes) { attributes_for(:trip).slice(:trip_kind_id, :order_id,:time_window_id,:address_id,:date) }
    #
    #   describe 'with valid params' do
    #
    #     it 'updates the requested trip' do
    #       put trip_path(trip), params: json_api_params(Trip, new_attributes), headers: headers, as: :json
    #       trip.reload
    #       expect(trip.attributes.with_indifferent_access).to include(new_attributes)
    #     end
    #
    #     it 'responds with :ok' do
    #       put trip_path(trip), params: json_api_params(Trip, new_attributes), headers: headers, as: :json
    #       expect(response).to have_http_status(:ok)
    #     end
    #   end
    #
    #   describe 'with invalid params' do
    #     it 'it responds with :unprocessable_entity' do
    #       put trip_path(trip), params: json_api_params(Trip, {trip_kind_id: nil, order_id: nil, date: nil, time_window_id: nil, address_id: nil}), headers: headers, as: :json
    #       expect(response).to have_http_status(:unprocessable_entity)
    #     end
    #   end
    #
    #   describe 'with missing item' do
    #     it 'responds with :not_found' do
    #       put trip_path(-1000), params: json_api_params(Trip, new_attributes), headers: headers, as: :json
    #       expect(response).to have_http_status(:not_found)
    #     end
    #   end
    # end

    # describe 'DELETE /trips/:id' do
    #   let!(:trip) { create :trip }
    #
    #   it 'for existing item, responds with :no_content' do
    #     delete trip_path(trip), headers: headers, as: :json
    #     expect(response).to have_http_status(:no_content)
    #   end
    #   it 'for missing item, responds with :not_found' do
    #     delete trip_path(-1000), headers: headers, as: :json
    #     expect(response).to have_http_status(:not_found)
    #   end
    # end
end
