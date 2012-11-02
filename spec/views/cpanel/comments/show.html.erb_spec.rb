require 'spec_helper'

describe "cpanel/comments/show" do
  before(:each) do
    @cpanel_comment = assign(:cpanel_comment, stub_model(Cpanel::Comment,
      :body => "Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Body/)
  end
end
