require 'spec_helper'

describe "cpanel/users/edit" do
  before(:each) do
    @cpanel_user = assign(:cpanel_user, stub_model(Cpanel::User,
      :name => "MyString",
      :email => "MyString",
      :gender => 1,
      :ilike => "MyString",
      :discover => "MyString",
      :info => "MyString",
      :school => "MyString",
      :tagline => "MyString"
    ))
  end

  it "renders the edit cpanel_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cpanel_users_path(@cpanel_user), :method => "post" do
      assert_select "input#cpanel_user_name", :name => "cpanel_user[name]"
      assert_select "input#cpanel_user_email", :name => "cpanel_user[email]"
      assert_select "input#cpanel_user_gender", :name => "cpanel_user[gender]"
      assert_select "input#cpanel_user_ilike", :name => "cpanel_user[ilike]"
      assert_select "input#cpanel_user_discover", :name => "cpanel_user[discover]"
      assert_select "input#cpanel_user_info", :name => "cpanel_user[info]"
      assert_select "input#cpanel_user_school", :name => "cpanel_user[school]"
      assert_select "input#cpanel_user_tagline", :name => "cpanel_user[tagline]"
    end
  end
end
