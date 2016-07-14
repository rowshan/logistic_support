require 'rails_helper'

RSpec.describe "Schedules", type: :request do
    before {
      controller_instance_stub_token_authentication(SchedulesController)
    }

    let(:headers) {
      {}.merge(token_authentication).merge(json_api_headers)
    }

    describe "GET /schedules" do
      let!(:schedules) { create_list :schedule, rand(5..10) }

      it 'responds with :ok' do
        get schedules_path, headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'responds with a list' do
        get schedules_path, headers: headers, as: :json
        expect(json_api_response).to be_a(Array)

      end

      it 'responds with a correct list' do
        get schedules_path, headers: headers, as: :json
        expect(json_api_response.size).to eq(schedules.count)
        expect(schedules.map(&:id)).to include(json_api_response.first['id'])
        expect(json_api_response.first['attributes']).to include('date','url')
        expect(json_api_response.first['relationships']).to include('driver','shift')
      end

    end

    describe 'GET /schedules/:id' do
      let!(:schedule) { create :schedule }

      describe 'for existing item' do
        it 'is a valid JSON API response' do
          get schedule_path(schedule), headers: headers, as: :json
          expect(response.body).to be_json_api_response_for(Schedule)
        end
        it 'responds with the correct item' do
          get schedule_path(schedule), headers: headers, as: :json
          expect(json_api_response['id']).to eq(schedule.id.to_s)
        end

        it 'responds with the correct information' do
          get schedule_path(schedule), headers: headers, as: :json
          expect(json_api_response['attributes']).to include('date', 'url')
        end

        it 'responds with :ok' do
          get schedule_path(schedule), headers: headers, as: :json
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'for missing item' do
        it 'responds with :not_found' do
          get schedule_path(-1000), headers: headers, as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe 'POST /schedules' do
      let!(:shift) { create :shift }
      let!(:driver) { create :driver }
      describe 'with valid params' do

        it 'responds with :created' do
          _attrs = attributes_for(:schedule).slice( :date, :start_time, :shift_id,:driver_id).update(
              :shift_id=> shift.to_param,:driver_id=>driver.to_param)
          post schedules_path, params: {:shift_id=> shift.to_param,:driver_id=>driver.to_param}.merge(
              json_api_params(Schedule, _attrs)), headers: headers, as: :json
          expect(response).to have_http_status(:created)

        end
      end

      describe 'with invalid params' do
        it 'responds with :unprocessable_entity' do
          post schedules_path, params: {:shift_id=> shift.to_param,:driver_id=>driver.to_param}.merge(
              json_api_params(Schedule, {date: nil})
          ), headers: headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'PUT /schedules/:id' do
      let!(:schedule) { create :schedule }
      let(:new_attributes) { attributes_for(:schedule) }

      describe 'with valid params' do

        it 'updates the requested time_window' do
          put schedule_path(schedule), params: json_api_params(Schedule, new_attributes), headers: headers, as: :json
          schedule.reload
          new_attributes.slice(:shift_id, :driver_id, :date) do
            expect(schedule.attributes.with_indifferent_access).to include(new_attributes)
          end

        end

        it 'responds with :ok' do
          put schedule_path(schedule), params: json_api_params(Schedule, new_attributes), headers: headers, as: :json
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'with invalid params' do
        it 'it responds with :unprocessable_entity' do
          put schedule_path(schedule), params: json_api_params(Schedule, {date: nil}
          ), headers: headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      describe 'with missing item' do
        it 'responds with :not_found' do
          put schedule_path(-1000), params: json_api_params(Schedule, new_attributes), headers: headers, as: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe 'DELETE /schedules/:id' do
      let!(:schedule) { create :schedule }

      it 'for existing item, responds with :no_content' do
        delete schedule_path(schedule), headers: headers, as: :json
        expect(response).to have_http_status(:no_content)
      end
      it 'for missing item, responds with :not_found' do
        delete schedule_path(-1000), headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end
