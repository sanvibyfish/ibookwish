# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
  	sequence(:isbn){|n| "123456789012#{n}" }
    sequence(:dream){|n| "dream#{n}" }
    sequence(:title){|n| "title#{n}" }
 	coordinates ["22.5879","114.0698" ]
    association :location
  end

end
