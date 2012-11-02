require "spec_helper"

describe Cpanel::UsersController do
  describe "routing" do

    it "routes to #index" do
      get("/cpanel/users").should route_to("cpanel/users#index")
    end

    it "routes to #new" do
      get("/cpanel/users/new").should route_to("cpanel/users#new")
    end

    it "routes to #show" do
      get("/cpanel/users/1").should route_to("cpanel/users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cpanel/users/1/edit").should route_to("cpanel/users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cpanel/users").should route_to("cpanel/users#create")
    end

    it "routes to #update" do
      put("/cpanel/users/1").should route_to("cpanel/users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cpanel/users/1").should route_to("cpanel/users#destroy", :id => "1")
    end

  end
end
