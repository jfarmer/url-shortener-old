require "rails_helper"

RSpec.describe LinksController, :type => :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/").to route_to("links#index")
    end

    it "routes to #new" do
      expect(:get => "/links/new").to route_to("links#new")
    end

    it "routes to #create" do
      expect(:post => "/links").to route_to("links#create")
    end

    it "routes to #show" do
      expect(:get => "/l/1").to route_to("links#show", :short_name => "1")
    end

    it "routes to #edit" do
      expect(:get => "/l/1/edit").to route_to("links#edit", :short_name => "1")
    end

    it "routes to #update (PUT)" do
      expect(:put => "/l/1").to route_to("links#update", :short_name => "1")
    end

    it "routes to #update (PATCH)" do
      expect(:patch => "/l/1").to route_to("links#update", :short_name => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/l/1").to route_to("links#destroy", :short_name => "1")
    end
  end
end
