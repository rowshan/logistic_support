require 'rails_helper'

RSpec.describe "TimeWindows", type: :request do
  before {
    controller_instance_stub_token_authentication(TimeWindowsController)
  }

  let(:headers) {
    {}.merge(token_authentication).merge(json_api_headers)
  }

  describe "GET /time_windows" do
    let!(:time_windows) { create_list :time_window, rand(5..10) }

    it 'responds with :ok' do
      get time_windows_path, headers: headers, as: :json
      expect(response).to have_http_status(:ok)
    end

    it 'responds with a list' do
      get time_windows_path, headers: headers, as: :json
      expect(json_api_response).to be_a(Array)
    end

    it 'responds with a correct list' do
      get time_windows_path, headers: headers, as: :json
      expect(json_api_response.size).to eq(time_windows.count)
      expect(time_windows.map(&:id)).to include(json_api_response.first['id'])
      expect(json_api_response.first['attributes']).to include('label', 'start-time', 'end-time', 'tenant-id', 'url')
      expect(json_api_response.first['relationships']).to include('shifts')

    end

  end

  describe 'GET /time_windows/:id' do
    let!(:time_window) { create :time_window }

    describe 'for existing item' do
      it 'is a valid JSON API response' do
        get time_window_path(time_window), headers: headers, as: :json
        expect(response.body).to be_json_api_response_for(TimeWindow)
      end
      it 'responds with the correct item' do
        get time_window_path(time_window), headers: headers, as: :json
        expect(json_api_response['id']).to eq(time_window.id.to_s)
      end

      it 'responds with the correct information' do
        get time_window_path(time_window), headers: headers, as: :json
        expect(json_api_response['attributes']).to include('label', 'start-time', 'end-time', 'tenant-id', 'url')
      end

      it 'responds with :ok' do
        get time_window_path(time_window), headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'for missing item' do
      it 'responds with :not_found' do
        get time_window_path(-1000), headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /time_windows' do
    describe 'with valid params' do
      it 'responds with :created' do
        _attrs = attributes_for(:time_window).slice( :tenant_id, :start_time, :end_time)
        post time_windows_path, params: json_api_params(TimeWindow, _attrs), headers: headers, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    describe 'with invalid params' do
      it 'responds with :unprocessable_entity' do
        post time_windows_path, params: json_api_params(TimeWindow, {tenant_id: nil,start_time:nil, end_time:nil}), headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /time_windows/:id' do
    let!(:time_window) { create :time_window }
    let(:new_attributes) { attributes_for(:time_window).slice(:tenant_id, :start_time, :end_time) }

    describe 'with valid params' do

      it 'updates the requested time_window' do
        put time_window_path(time_window), params: json_api_params(TimeWindow, new_attributes), headers: headers, as: :json
        time_window.reload
        expect(time_window.attributes.with_indifferent_access).to include(new_attributes)
      end

      it 'responds with :ok' do
        put time_window_path(time_window), params: json_api_params(TimeWindow, new_attributes), headers: headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'with invalid params' do
      it 'it responds with :unprocessable_entity' do
        put time_window_path(time_window), params: json_api_params(TimeWindow, {tenant_id: nil,start_time:nil, end_time:nil}), headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'with missing item' do
      it 'responds with :not_found' do
        put time_window_path(-1000), params: json_api_params(TimeWindow, new_attributes), headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /time_windows/:id' do
    let!(:time_window) { create :time_window }

    it 'for existing item, responds with :no_content' do
      delete time_window_path(time_window), headers: headers, as: :json
      expect(response).to have_http_status(:no_content)
    end
    it 'for missing item, responds with :not_found' do
      delete time_window_path(-1000), headers: headers, as: :json
      expect(response).to have_http_status(:not_found)
    end
  end
end
