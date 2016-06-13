require "rails_helper"

RSpec.describe TimeWindowsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/time_windows").to route_to("time_windows#index")
    end

    it "routes to #new" do
      expect(:get => "/time_windows/new").to route_to("time_windows#new")
    end

    it "routes to #show" do
      expect(:get => "/time_windows/1").to route_to("time_windows#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/time_windows/1/edit").to route_to("time_windows#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/time_windows").to route_to("time_windows#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/time_windows/1").to route_to("time_windows#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/time_windows/1").to route_to("time_windows#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/time_windows/1").to route_to("time_windows#destroy", :id => "1")
    end

  end
end
