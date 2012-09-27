require 'spec_helper'

describe PostsController do
  let(:post) { FactoryGirl.create(:post) }
  let(:location){ FactoryGirl.create(:location) }
  let(:account){ FactoryGirl.create(:account) }
  describe ":new" do
    it "should new action" do
      sign_in account
      get :new
      response.should be_success
    end
  end


  describe ":get_book" do
    it "should get_book action" do
      sign_in account
      get :get_book, :isbn => "9787544715690",:format => :js
      response.should be_success
    end
  end

  describe ":create" do
    it "should create action" do
      sign_in account
      params = FactoryGirl.attributes_for(:post)
      post :create, :post => params, :lat => "22.5879", :lng =>  "114.0698" 
      response.should_not be_success
    end
  end

  describe ":near_me" do
    it "should near_me action" do
      sign_in account
      get :near_me, :page => 1, :id => location.name
      response.should be_success
    end
  end

  describe ":get_posts" do
    it "should get_posts action" do
      sign_in account
      get :get_posts, :page => 2
      response.should be_success
    end
  end

  describe ":index" do
    it "should index action" do
      sign_in account
      get :index, :page => 1, :location => location.id
      response.should be_success
    end
  end







end
