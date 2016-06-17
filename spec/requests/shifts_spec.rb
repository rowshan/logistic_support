require 'rails_helper'

RSpec.describe "Shifts", type: :request do
    before {
      controller_instance_stub_token_authentication(ShiftsController)
    }

    let(:headers) {
      {}.merge(token_authentication).merge(json_api_headers)
    }

    describe "GET /shifts" do
      let!(:shifts) { create_list :shift, rand(5..10) }

      it 'responds with :ok' do
        get shifts_path, headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'responds with a list' do
        get shifts_path, headers: headers, as: :json
        expect(json_api_response).to be_a(Array)
      end

      it 'responds with a correct list' do
        get shifts_path, headers: headers, as: :json
        expect(json_api_response.size).to eq(shifts.count)
        expect(shifts.map(&:id)).to include(json_api_response.first['id'])
        expect(json_api_response.first['attributes']).to include('name', 'start-time', 'end-time', 'send-time','enabled', 'url')
        expect(json_api_response.first['relationships']).to include('time-window')

      end

    end

    describe 'GET /shifts/:id' do
      let!(:shift) { create :shift }

      describe 'for existing item' do
        it 'is a valid JSON API response' do
          get shift_path(shift), headers: headers, as: :json
          expect(response.body).to be_json_api_response_for(Shift)
        end
        it 'responds with the correct item' do
          get shift_path(shift), headers: headers, as: :json
          expect(json_api_response['id']).to eq(shift.id.to_s)
        end

        it 'responds with the correct information' do
          get shift_path(shift), headers: headers, as: :json
          expect(json_api_response['attributes']).to include('name','time-window-id', 'start-time', 'end-time', 'send-time','enabled', 'url')
        end

        it 'responds with :ok' do
          get shift_path(shift), headers: headers, as: :json
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'for missing item' do
        it 'responds with :not_found' do
          get shift_path(-1000), headers: headers, as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe 'POST /shifts' do
      describe 'with valid params' do
        it 'responds with :created' do
          _attrs = attributes_for(:shift).slice( :name, :start_time, :end_time,:send_time)
          p _attrs
          post shifts_path, params: json_api_params(Shift, _attrs), headers: headers, as: :json
          expect(response).to have_http_status(:created)
        end
      end

      describe 'with invalid params' do
        it 'responds with :unprocessable_entity' do
          post shifts_path, params: json_api_params(Shift, {name: nil,start_time:nil, end_time:nil,send_time:nil}), headers: headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'PUT /shifts/:id' do
      let!(:shift) { create :shift }
      let(:new_attributes) { attributes_for(:shift).slice(:name, :start_time, :end_time,:send_time) }

      describe 'with valid params' do

        it 'updates the requested time_window' do
          put shift_path(shift), params: json_api_params(Shift, new_attributes), headers: headers, as: :json
          shift.reload
          expect(shift.attributes.with_indifferent_access).to include(new_attributes)
        end

        it 'responds with :ok' do
          put shift_path(shift), params: json_api_params(Shift, new_attributes), headers: headers, as: :json
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'with invalid params' do
        it 'it responds with :unprocessable_entity' do
          put shift_path(shift), params: json_api_params(Shift, {name: nil,start_time:nil, end_time:nil,send_time:nil}), headers: headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      describe 'with missing item' do
        it 'responds with :not_found' do
          put shift_path(-1000), params: json_api_params(Shift, new_attributes), headers: headers, as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe 'DELETE /shifts/:id' do
      let!(:shift) { create :shift }

      it 'for existing item, responds with :no_content' do
        delete shift_path(shift), headers: headers, as: :json
        expect(response).to have_http_status(:no_content)
      end
      it 'for missing item, responds with :not_found' do
        delete shift_path(-1000), headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
end
