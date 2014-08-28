module Chatty::ChatsHelper
  CHATTY_CHAT_ALLOWED_KEYS = [:data]
  def chatty_chat chat, args = {}
    args.each do |key, val|
      raise ArgumentError, "Invalid key: #{key}" unless CHATTY_CHAT_ALLOWED_KEYS.include?(key)
    end

    data = {
      chat_id: chat.id,
      signed_in: signed_in?,
      can_add_messages: can?(:new, Chatty::Message),
      need_to_be_signed_in_message: _("You need to be signed in to write messages."),
      not_allowed_to_add_messages_message: _("You are not allowed to write messages."),
      waiting_to_connect_message: _("Waiting to connect..."),
      waiting_to_be_handled_message: _("Waiting to be handled..."),
      chat_is_closed_message: _("This chat is closed.")
    }

    data = data.merge(args[:data]) if args[:data]

    content_tag(:div, nil, {
      class: "chatty_chat",
      data: data
    })
  end
end
