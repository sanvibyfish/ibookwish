require 'spec_helper'

describe "cpanel/comments/index" do
  before(:each) do
    assign(:cpanel_comments, [
      stub_model(Cpanel::Comment,
        :body => "Body"
      ),
      stub_model(Cpanel::Comment,
        :body => "Body"
      )
    ])
  end

  it "renders a list of cpanel/comments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Body".to_s, :count => 2
  end
end
