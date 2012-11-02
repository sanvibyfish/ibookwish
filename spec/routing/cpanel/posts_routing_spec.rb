require "spec_helper"

describe Cpanel::PostsController do
  describe "routing" do

    it "routes to #index" do
      get("/cpanel/posts").should route_to("cpanel/posts#index")
    end

    it "routes to #new" do
      get("/cpanel/posts/new").should route_to("cpanel/posts#new")
    end

    it "routes to #show" do
      get("/cpanel/posts/1").should route_to("cpanel/posts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cpanel/posts/1/edit").should route_to("cpanel/posts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cpanel/posts").should route_to("cpanel/posts#create")
    end

    it "routes to #update" do
      put("/cpanel/posts/1").should route_to("cpanel/posts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cpanel/posts/1").should route_to("cpanel/posts#destroy", :id => "1")
    end

  end
end
