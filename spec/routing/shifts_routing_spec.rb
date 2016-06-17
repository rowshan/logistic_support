require "rails_helper"

RSpec.describe ShiftsController, type: :routing do
  describe "routing" do
    let(:scope) { '/logistic' }

    it "routes to #index" do
      expect(:get => "#{scope}/shifts").to route_to("shifts#index")
    end

    it "routes to #show" do
      expect(:get => "#{scope}/shifts/1").to route_to("shifts#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "#{scope}/shifts").to route_to("shifts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "#{scope}/shifts/1").to route_to("shifts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{scope}/shifts/1").to route_to("shifts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "#{scope}/shifts/1").to route_to("shifts#destroy", :id => "1")
    end

  end
end
