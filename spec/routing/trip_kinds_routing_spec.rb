require "rails_helper"

RSpec.describe TripKindsController, type: :routing do
  describe "routing" do
    let(:scope) { '/logistic' }

    it "routes to #index" do
      expect(:get => "#{scope}/trip_kinds").to route_to("trip_kinds#index")
    end

    it "routes to #show" do
      expect(:get => "#{scope}/trip_kinds/1").to route_to("trip_kinds#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "#{scope}/trip_kinds").to route_to("trip_kinds#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "#{scope}/trip_kinds/1").to route_to("trip_kinds#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{scope}/trip_kinds/1").to route_to("trip_kinds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "#{scope}/trip_kinds/1").to route_to("trip_kinds#destroy", :id => "1")
    end

  end
end
