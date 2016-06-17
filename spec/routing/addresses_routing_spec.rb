require "rails_helper"

RSpec.describe AddressesController, type: :routing do
  describe "routing" do
    let(:scope) { '/logistic' }

    it "routes to #index" do
      expect(:get => "#{scope}/addresses").to route_to("addresses#index")
    end

    it "routes to #show" do
      expect(:get => "#{scope}/addresses/1").to route_to("addresses#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "#{scope}/addresses").to route_to("addresses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "#{scope}/addresses/1").to route_to("addresses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{scope}/addresses/1").to route_to("addresses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "#{scope}/addresses/1").to route_to("addresses#destroy", :id => "1")
    end

  end
end