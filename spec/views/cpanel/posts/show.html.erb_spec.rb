require 'spec_helper'

describe "cpanel/posts/show" do
  before(:each) do
    @cpanel_post = assign(:cpanel_post, stub_model(Cpanel::Post,
      :isbn => "",
      :author => "Author",
      :title => "Title",
      :publisher => "Publisher",
      :price => "Price",
      :description => "Description",
      :dream => "Dream",
      :address => "Address",
      :rating_body => "Rating Body",
      :rating => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Author/)
    rendered.should match(/Title/)
    rendered.should match(/Publisher/)
    rendered.should match(/Price/)
    rendered.should match(/Description/)
    rendered.should match(/Dream/)
    rendered.should match(/Address/)
    rendered.should match(/Rating Body/)
    rendered.should match(/1/)
  end
end
