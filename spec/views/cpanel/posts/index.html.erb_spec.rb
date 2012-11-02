require 'spec_helper'

describe "cpanel/posts/index" do
  before(:each) do
    assign(:cpanel_posts, [
      stub_model(Cpanel::Post,
        :isbn => "",
        :author => "Author",
        :title => "Title",
        :publisher => "Publisher",
        :price => "Price",
        :description => "Description",
        :dream => "Dream",
        :address => "Address",
        :rating_body => "Rating Body",
        :rating => 1
      ),
      stub_model(Cpanel::Post,
        :isbn => "",
        :author => "Author",
        :title => "Title",
        :publisher => "Publisher",
        :price => "Price",
        :description => "Description",
        :dream => "Dream",
        :address => "Address",
        :rating_body => "Rating Body",
        :rating => 1
      )
    ])
  end

  it "renders a list of cpanel/posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Publisher".to_s, :count => 2
    assert_select "tr>td", :text => "Price".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Dream".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Rating Body".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
