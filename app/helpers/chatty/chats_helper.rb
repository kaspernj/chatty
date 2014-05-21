module Chatty::ChatsHelper
  def chatty_chat(chat)
    content_tag :div, nil, :class => "chatty_chat", :data => {:chat_id => chat.id}
  end
end
