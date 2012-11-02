require "spec_helper"

describe Cpanel::ApplyForTestsController do
  describe "routing" do

    it "routes to #index" do
      get("/cpanel/apply_for_tests").should route_to("cpanel/apply_for_tests#index")
    end

    it "routes to #new" do
      get("/cpanel/apply_for_tests/new").should route_to("cpanel/apply_for_tests#new")
    end

    it "routes to #show" do
      get("/cpanel/apply_for_tests/1").should route_to("cpanel/apply_for_tests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cpanel/apply_for_tests/1/edit").should route_to("cpanel/apply_for_tests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cpanel/apply_for_tests").should route_to("cpanel/apply_for_tests#create")
    end

    it "routes to #update" do
      put("/cpanel/apply_for_tests/1").should route_to("cpanel/apply_for_tests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cpanel/apply_for_tests/1").should route_to("cpanel/apply_for_tests#destroy", :id => "1")
    end

  end
end
