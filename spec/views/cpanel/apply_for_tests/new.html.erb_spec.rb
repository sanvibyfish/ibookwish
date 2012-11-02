require 'spec_helper'

describe "cpanel/apply_for_tests/new" do
  before(:each) do
    assign(:cpanel_apply_for_test, stub_model(Cpanel::ApplyForTest,
      :email => "MyString",
      :name => "MyString",
      :state => 1
    ).as_new_record)
  end

  it "renders new cpanel_apply_for_test form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cpanel_apply_for_tests_path, :method => "post" do
      assert_select "input#cpanel_apply_for_test_email", :name => "cpanel_apply_for_test[email]"
      assert_select "input#cpanel_apply_for_test_name", :name => "cpanel_apply_for_test[name]"
      assert_select "input#cpanel_apply_for_test_state", :name => "cpanel_apply_for_test[state]"
    end
  end
end
