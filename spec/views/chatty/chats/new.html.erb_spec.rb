require 'spec_helper'

describe "chats/new" do
  before(:each) do
    assign(:chat, stub_model(Chat,
      :user_type => "MyString",
      :user_id => 1,
      :resource_type => "MyString",
      :resource_id => 1,
      :handled => false
    ).as_new_record)
  end

  it "renders new chat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", chats_path, "post" do
      assert_select "input#chat_user_type[name=?]", "chat[user_type]"
      assert_select "input#chat_user_id[name=?]", "chat[user_id]"
      assert_select "input#chat_resource_type[name=?]", "chat[resource_type]"
      assert_select "input#chat_resource_id[name=?]", "chat[resource_id]"
      assert_select "input#chat_handled[name=?]", "chat[handled]"
    end
  end
end
