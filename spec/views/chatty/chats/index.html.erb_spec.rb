require 'spec_helper'

describe "chats/index" do
  before(:each) do
    assign(:chats, [
      stub_model(Chat,
        :user_type => "User Type",
        :user_id => 1,
        :resource_type => "Resource Type",
        :resource_id => 2,
        :handled => false
      ),
      stub_model(Chat,
        :user_type => "User Type",
        :user_id => 1,
        :resource_type => "Resource Type",
        :resource_id => 2,
        :handled => false
      )
    ])
  end

  it "renders a list of chats" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Resource Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
