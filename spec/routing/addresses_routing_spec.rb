require "rails_helper"

RSpec.describe AddressesController, type: :routing do
  describe "routing" do
    let(:scope) { '/logistic' }

    it "routes to #show" do
      expect(:get => "#{scope}/trips/1/address").to route_to("addresses#show", :trip_id => "1")
    end

    it "routes to #create" do
      expect(:post => "#{scope}/trips/1/address").to route_to("addresses#create",:trip_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "#{scope}/trips/1/address").to route_to("addresses#update", :trip_id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{scope}/trips/1/address").to route_to("addresses#update", :trip_id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "#{scope}/trips/1/address").to route_to("addresses#destroy", :trip_id => "1")
    end

  end
end
