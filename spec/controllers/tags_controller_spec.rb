require 'spec_helper'

describe TagsController do
  let(:tag) { FactoryGirl.create(:tag) }

  describe ":autocomplete" do
    it "should have an autocomplete action" do
      get :autocomplete, :q => tag.name, :format => :json
      response.should be_success
    end
  end

  describe ":show" do
    it "should show action" do
      get :show, :id => tag.name
      response.should be_success
    end

    it "should render 404 if tag not found" do
      get :show, :id => "chunk_norris"
      response.should_not be_success
      response.status.should == 404
    end
  end

end
