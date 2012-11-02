require 'spec_helper'

describe "cpanel/comments/edit" do
  before(:each) do
    @cpanel_comment = assign(:cpanel_comment, stub_model(Cpanel::Comment,
      :body => "MyString"
    ))
  end

  it "renders the edit cpanel_comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cpanel_comments_path(@cpanel_comment), :method => "post" do
      assert_select "input#cpanel_comment_body", :name => "cpanel_comment[body]"
    end
  end
end
