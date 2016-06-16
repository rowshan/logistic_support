require "rails_helper"

RSpec.describe TripsController, type: :routing do
  describe "routing" do
    let(:scope) { '/logistic' }

    it "routes to #index" do
      expect(:get => "#{scope}/trips").to route_to("trips#index")
    end

    it "routes to #show" do
      expect(:get => "#{scope}/trips/1").to route_to("trips#show", :id => "1")
    end
    it "routes to #create" do
      expect(:post => "#{scope}/trips").to route_to("trips#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "#{scope}/trips/1").to route_to("trips#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{scope}/trips/1").to route_to("trips#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "#{scope}/trips/1").to route_to("trips#destroy", :id => "1")
    end

  end
end
