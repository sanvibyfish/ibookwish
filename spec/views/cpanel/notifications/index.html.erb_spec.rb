require 'spec_helper'

describe "cpanel/notifications/index" do
  before(:each) do
    assign(:cpanel_notifications, [
      stub_model(Cpanel::Notification,
        :body => "Body",
        :read => false,
        :notif_type => 1
      ),
      stub_model(Cpanel::Notification,
        :body => "Body",
        :read => false,
        :notif_type => 1
      )
    ])
  end

  it "renders a list of cpanel/notifications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Body".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
