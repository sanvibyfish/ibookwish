#coding: utf-8
FactoryGirl.define do
	factory :account do
		nickname 'name'
		sequence(:email){|n| "email#{n}@bookdate.cn" }
    	password 'password'
    	password_confirmation 'password'
    	gender 0
	end
 
end