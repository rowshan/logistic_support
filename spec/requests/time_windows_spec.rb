require 'rails_helper'

RSpec.describe "TimeWindows", type: :request do
  describe "GET /time_windows" do
    it "works! (now write some real specs)" do
      get time_windows_path
      expect(response).to have_http_status(200)
    end
  end
end
