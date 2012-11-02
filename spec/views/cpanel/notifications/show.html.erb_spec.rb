require 'spec_helper'

describe "cpanel/notifications/show" do
  before(:each) do
    @cpanel_notification = assign(:cpanel_notification, stub_model(Cpanel::Notification,
      :body => "Body",
      :read => false,
      :notif_type => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Body/)
    rendered.should match(/false/)
    rendered.should match(/1/)
  end
end
