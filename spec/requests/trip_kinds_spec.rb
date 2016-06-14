require 'rails_helper'

RSpec.describe "TripKinds", type: :request do
  describe "GET /trip_kinds" do
    it "works! (now write some real specs)" do
      get trip_kinds_path
      expect(response).to have_http_status(200)
    end
  end
end
