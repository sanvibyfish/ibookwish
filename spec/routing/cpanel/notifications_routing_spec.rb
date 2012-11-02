require "spec_helper"

describe Cpanel::NotificationsController do
  describe "routing" do

    it "routes to #index" do
      get("/cpanel/notifications").should route_to("cpanel/notifications#index")
    end

    it "routes to #new" do
      get("/cpanel/notifications/new").should route_to("cpanel/notifications#new")
    end

    it "routes to #show" do
      get("/cpanel/notifications/1").should route_to("cpanel/notifications#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cpanel/notifications/1/edit").should route_to("cpanel/notifications#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cpanel/notifications").should route_to("cpanel/notifications#create")
    end

    it "routes to #update" do
      put("/cpanel/notifications/1").should route_to("cpanel/notifications#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cpanel/notifications/1").should route_to("cpanel/notifications#destroy", :id => "1")
    end

  end
end
