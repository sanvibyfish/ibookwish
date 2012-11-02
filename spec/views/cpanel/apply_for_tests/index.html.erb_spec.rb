require 'spec_helper'

describe "cpanel/apply_for_tests/index" do
  before(:each) do
    assign(:cpanel_apply_for_tests, [
      stub_model(Cpanel::ApplyForTest,
        :email => "Email",
        :name => "Name",
        :state => 1
      ),
      stub_model(Cpanel::ApplyForTest,
        :email => "Email",
        :name => "Name",
        :state => 1
      )
    ])
  end

  it "renders a list of cpanel/apply_for_tests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
