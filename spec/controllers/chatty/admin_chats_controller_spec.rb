require "spec_helper"

describe Chatty::AdminChatsController do
  context "#handle" do
    let(:chat){ create :chatty_chat }

    it "should handle a chat an log the handling" do
      post :handle, id: chat.id, use_route: "chatty"
      chat.reload
      chat.state.should eq "handled"
      chat.activities.where(key: "chatty/chat.handled").length.should eq 1
    end
  end
end
