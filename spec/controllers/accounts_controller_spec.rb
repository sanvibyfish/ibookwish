# coding: utf-8
require "spec_helper"
 
describe AccountsController do

　 before :each do # 在每次请求前，登录。  没有这个，访问时会被devise拒绝。
　　  @account = FactoryGirl.create(:account)
　　　 sign_in @account
　 end
 
　　describe "GET welcome" do
　　　 it "should be successful" do
 　　　　 get 'welcome'
　　　　  response.should be_success
　　　 end
　 end
 
end