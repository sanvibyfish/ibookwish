require 'spec_helper'

describe "cpanel/users/index" do
  before(:each) do
    assign(:cpanel_users, [
      stub_model(Cpanel::User,
        :name => "Name",
        :email => "Email",
        :gender => 1,
        :ilike => "Ilike",
        :discover => "Discover",
        :info => "Info",
        :school => "School",
        :tagline => "Tagline"
      ),
      stub_model(Cpanel::User,
        :name => "Name",
        :email => "Email",
        :gender => 1,
        :ilike => "Ilike",
        :discover => "Discover",
        :info => "Info",
        :school => "School",
        :tagline => "Tagline"
      )
    ])
  end

  it "renders a list of cpanel/users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Ilike".to_s, :count => 2
    assert_select "tr>td", :text => "Discover".to_s, :count => 2
    assert_select "tr>td", :text => "Info".to_s, :count => 2
    assert_select "tr>td", :text => "School".to_s, :count => 2
    assert_select "tr>td", :text => "Tagline".to_s, :count => 2
  end
end
