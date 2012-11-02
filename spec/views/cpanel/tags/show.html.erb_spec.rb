require 'spec_helper'

describe "cpanel/tags/show" do
  before(:each) do
    @cpanel_tag = assign(:cpanel_tag, stub_model(Cpanel::Tag,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
