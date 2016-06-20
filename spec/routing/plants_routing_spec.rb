require "rails_helper"

RSpec.describe PlantsController, type: :routing do
  describe "routing" do
    let(:scope) { '/logistic' }

    it "routes to #index" do
      expect(:get => "#{scope}/plants").to route_to("plants#index")
    end

    it "routes to #show" do
      expect(:get => "#{scope}/plants/1").to route_to("plants#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "#{scope}/plants").to route_to("plants#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "#{scope}/plants/1").to route_to("plants#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{scope}/plants/1").to route_to("plants#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "#{scope}/plants/1").to route_to("plants#destroy", :id => "1")
    end

  end
end
