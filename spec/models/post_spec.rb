#coding: utf-8

require 'spec_helper'

describe Post do
	let(:post) { FactoryGirl.create(:post) }


	context "method" do
	  it "#assign_tags" do
	     @post = FactoryGirl.create(:post,:tag_names => "aa,bb,cc")
	     @post.tags.map { |tag|
	     	%w(aa bb cc).should include(tag.name)
	     }

	  end
	end




end
