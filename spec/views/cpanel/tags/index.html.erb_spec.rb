require 'spec_helper'

describe "cpanel/tags/index" do
  before(:each) do
    assign(:cpanel_tags, [
      stub_model(Cpanel::Tag,
        :name => "Name"
      ),
      stub_model(Cpanel::Tag,
        :name => "Name"
      )
    ])
  end

  it "renders a list of cpanel/tags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
