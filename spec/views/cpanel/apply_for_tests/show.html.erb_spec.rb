require 'spec_helper'

describe "cpanel/apply_for_tests/show" do
  before(:each) do
    @cpanel_apply_for_test = assign(:cpanel_apply_for_test, stub_model(Cpanel::ApplyForTest,
      :email => "Email",
      :name => "Name",
      :state => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
