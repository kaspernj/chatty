require 'spec_helper'

describe "chats/show" do
  before(:each) do
    @chat = assign(:chat, stub_model(Chat,
      :user_type => "User Type",
      :user_id => 1,
      :resource_type => "Resource Type",
      :resource_id => 2,
      :handled => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User Type/)
    rendered.should match(/1/)
    rendered.should match(/Resource Type/)
    rendered.should match(/2/)
    rendered.should match(/false/)
  end
end
