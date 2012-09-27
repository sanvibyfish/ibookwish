#coding: utf-8

require 'spec_helper'

describe Tag do

	let(:tag) {FactoryGirl.create(:tag)}

	it "should validates_uniqueness_of :name ignore case" do
		Tag.create(:name => tag.name).should have(1).error_on(:name)
	end

	it "should #autocomplete assert 1 true" do
		Tag.autocomplete(tag.name).size().should == 1
	end

	it "should #autocomplete_data for FoO assert Array" do
		Tag.autocomplete_data(tag.name).class.should == Array
	end

	it "should #assign_tags assert true" do
	  Tag.assign_tags("旅行,囧,无聊").map{ |tag|
	  	%w(旅行 囧 无聊).should include(tag.name)
	  }
	end

end
