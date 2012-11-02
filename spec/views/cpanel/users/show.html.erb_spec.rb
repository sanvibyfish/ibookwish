require 'spec_helper'

describe "cpanel/users/show" do
  before(:each) do
    @cpanel_user = assign(:cpanel_user, stub_model(Cpanel::User,
      :name => "Name",
      :email => "Email",
      :gender => 1,
      :ilike => "Ilike",
      :discover => "Discover",
      :info => "Info",
      :school => "School",
      :tagline => "Tagline"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(/1/)
    rendered.should match(/Ilike/)
    rendered.should match(/Discover/)
    rendered.should match(/Info/)
    rendered.should match(/School/)
    rendered.should match(/Tagline/)
  end
end
