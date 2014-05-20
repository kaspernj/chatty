require 'spec_helper'

describe "chats/edit" do
  before(:each) do
    @chat = assign(:chat, stub_model(Chat,
      :user_type => "MyString",
      :user_id => 1,
      :resource_type => "MyString",
      :resource_id => 1,
      :handled => false
    ))
  end

  it "renders the edit chat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", chat_path(@chat), "post" do
      assert_select "input#chat_user_type[name=?]", "chat[user_type]"
      assert_select "input#chat_user_id[name=?]", "chat[user_id]"
      assert_select "input#chat_resource_type[name=?]", "chat[resource_type]"
      assert_select "input#chat_resource_id[name=?]", "chat[resource_id]"
      assert_select "input#chat_handled[name=?]", "chat[handled]"
    end
  end
end
