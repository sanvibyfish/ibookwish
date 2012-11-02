require 'spec_helper'

describe "cpanel/notifications/edit" do
  before(:each) do
    @cpanel_notification = assign(:cpanel_notification, stub_model(Cpanel::Notification,
      :body => "MyString",
      :read => false,
      :notif_type => 1
    ))
  end

  it "renders the edit cpanel_notification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cpanel_notifications_path(@cpanel_notification), :method => "post" do
      assert_select "input#cpanel_notification_body", :name => "cpanel_notification[body]"
      assert_select "input#cpanel_notification_read", :name => "cpanel_notification[read]"
      assert_select "input#cpanel_notification_notif_type", :name => "cpanel_notification[notif_type]"
    end
  end
end
