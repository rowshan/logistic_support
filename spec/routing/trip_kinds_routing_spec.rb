require "rails_helper"

RSpec.describe TripKindsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/trip_kinds").to route_to("trip_kinds#index")
    end

    it "routes to #show" do
      expect(:get => "/trip_kinds/1").to route_to("trip_kinds#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/trip_kinds").to route_to("trip_kinds#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trip_kinds/1").to route_to("trip_kinds#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trip_kinds/1").to route_to("trip_kinds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trip_kinds/1").to route_to("trip_kinds#destroy", :id => "1")
    end

  end
end
