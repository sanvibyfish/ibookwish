# coding: utf-8
require 'spec_helper'

describe Location do
	let(:location) { FactoryGirl.create(:location) }

	it "should validates_uniqueness_of :name ignore case" do
		Location.create(:name => location.name).should have(1).error_on(:name)
	end
end
