# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
  	sequence(:name){|n| "name#{n}" }
    sequence(:email){|n| "email#{n}@ruby-chine.org" }
    password 'password'
    password_confirmation 'password'
    gender 
  end

end
