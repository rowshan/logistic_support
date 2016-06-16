require "rails_helper"

RSpec.describe TimeWindowsController, type: :routing do
  describe "routing" do
    let(:scope) { '/logistic' }

    it "routes to #index" do
      expect(:get => "#{scope}/time_windows").to route_to("time_windows#index")
    end

    it "routes to #show" do
      expect(:get => "#{scope}/time_windows/1").to route_to("time_windows#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "#{scope}/time_windows").to route_to("time_windows#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "#{scope}/time_windows/1").to route_to("time_windows#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{scope}/time_windows/1").to route_to("time_windows#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "#{scope}/time_windows/1").to route_to("time_windows#destroy", :id => "1")
    end

  end
end
