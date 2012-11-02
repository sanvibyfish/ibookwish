require 'spec_helper'

describe "cpanel/comments/new" do
  before(:each) do
    assign(:cpanel_comment, stub_model(Cpanel::Comment,
      :body => "MyString"
    ).as_new_record)
  end

  it "renders new cpanel_comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cpanel_comments_path, :method => "post" do
      assert_select "input#cpanel_comment_body", :name => "cpanel_comment[body]"
    end
  end
end
