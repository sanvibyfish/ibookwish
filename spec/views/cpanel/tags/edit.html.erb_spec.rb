require 'spec_helper'

describe "cpanel/tags/edit" do
  before(:each) do
    @cpanel_tag = assign(:cpanel_tag, stub_model(Cpanel::Tag,
      :name => "MyString"
    ))
  end

  it "renders the edit cpanel_tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cpanel_tags_path(@cpanel_tag), :method => "post" do
      assert_select "input#cpanel_tag_name", :name => "cpanel_tag[name]"
    end
  end
end
