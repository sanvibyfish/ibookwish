require 'spec_helper'

describe "cpanel/posts/edit" do
  before(:each) do
    @cpanel_post = assign(:cpanel_post, stub_model(Cpanel::Post,
      :isbn => "",
      :author => "MyString",
      :title => "MyString",
      :publisher => "MyString",
      :price => "MyString",
      :description => "MyString",
      :dream => "MyString",
      :address => "MyString",
      :rating_body => "MyString",
      :rating => 1
    ))
  end

  it "renders the edit cpanel_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cpanel_posts_path(@cpanel_post), :method => "post" do
      assert_select "input#cpanel_post_isbn", :name => "cpanel_post[isbn]"
      assert_select "input#cpanel_post_author", :name => "cpanel_post[author]"
      assert_select "input#cpanel_post_title", :name => "cpanel_post[title]"
      assert_select "input#cpanel_post_publisher", :name => "cpanel_post[publisher]"
      assert_select "input#cpanel_post_price", :name => "cpanel_post[price]"
      assert_select "input#cpanel_post_description", :name => "cpanel_post[description]"
      assert_select "input#cpanel_post_dream", :name => "cpanel_post[dream]"
      assert_select "input#cpanel_post_address", :name => "cpanel_post[address]"
      assert_select "input#cpanel_post_rating_body", :name => "cpanel_post[rating_body]"
      assert_select "input#cpanel_post_rating", :name => "cpanel_post[rating]"
    end
  end
end
