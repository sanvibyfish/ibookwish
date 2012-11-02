require 'spec_helper'

describe "cpanel/tags/new" do
  before(:each) do
    assign(:cpanel_tag, stub_model(Cpanel::Tag,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new cpanel_tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cpanel_tags_path, :method => "post" do
      assert_select "input#cpanel_tag_name", :name => "cpanel_tag[name]"
    end
  end
end
