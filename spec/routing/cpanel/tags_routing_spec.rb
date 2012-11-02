require "spec_helper"

describe Cpanel::TagsController do
  describe "routing" do

    it "routes to #index" do
      get("/cpanel/tags").should route_to("cpanel/tags#index")
    end

    it "routes to #new" do
      get("/cpanel/tags/new").should route_to("cpanel/tags#new")
    end

    it "routes to #show" do
      get("/cpanel/tags/1").should route_to("cpanel/tags#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cpanel/tags/1/edit").should route_to("cpanel/tags#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cpanel/tags").should route_to("cpanel/tags#create")
    end

    it "routes to #update" do
      put("/cpanel/tags/1").should route_to("cpanel/tags#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cpanel/tags/1").should route_to("cpanel/tags#destroy", :id => "1")
    end

  end
end
