$ ->
  # Adds the messages element and waits for the chat to be handled.
  chatty_init = (chat) ->
    chat.addClass("chatty_chat_" + chat.data("chat-id"))
    
    messages = $("<div />", {
      "class": "chatty_messages",
      "text": chat.data("waiting-to-connect-message"),
      "css": {
        "display": "none"
      }
    })
    chat.append(messages)
    
    error = $("<div />", {
      "class": "chatty_not_allowed_to_add_messages",
      "text": chat.data("not-allowed-to-add-messages-message"),
      "css": {
        "display": "none"
      }
    })
    chat.prepend(error)
    
    error = $("<div />", {
      "class": "chatty_not_signed_in_error",
      "text": chat.data("need-to-be-signed-in-message"),
      "css": {
        "display": "none"
      }
    })
    chat.prepend(error)
    
    chatty_handled(chat, ->
      chatty_init_messages(chat, ->
        chatty_init_form(chat, ->
          chatty_refresh_messages(chat)
          chatty_check_new_messages(chat)
        )
      )
    )
  
  chatty_check_new_messages = (chat) ->
    setTimeout((->
      chatty_refresh_messages(chat)
      
      # Handle changed chat state.
      chatty_with_state(chat, (data) ->
        if data.chat.state != "handled"
          chatty_hide_form() unless chatty_form_hidden()
        else
          chatty_show_form() if chatty_form_hidden()
        
        if data.chat.state == "closed"
          chatty_show_not_allowed_to_add_messages() if chatty_not_allowed_to_add_messages_hidden()
        else
          chatty_hide_not_allowed_to_add_messages() unless chatty_not_allowed_to_add_messages_hidden()
      )
      
      chatty_check_new_messages(chat)
    ), 1000)
  
  chatty_show_not_allowed_to_add_messages = (chat) ->
    $(".chatty_not_allowed_to_add_messages", chat).slideDown("fast")
  
  chatty_hide_not_allowed_to_add_messages = (chat) ->
    $(".chatty_not_allowed_to_add_messages", chat).slideUp("fast")
  
  chatty_not_allowed_to_add_messages_hidden = (chat) ->
    $(".chatty_not_allowed_to_add_messages", chat).css("display") != "block"
  
  chatty_hide_form = (chat) ->
    $(".chatty_form", chat).slideUp("fast") unless chatty_form_hidden()
  
  chatty_form_hidden = (chat) ->
    $(".chatty_form", chat).css("display") != "block"
  
  chatty_show_form = (chat) ->
    $(".chatty_form", chat).slideDown("fast") if chatty_form_hidden()
  
  chatty_with_state = (chat, callback) ->
    $.ajax({type: "GET", url: "/chatty/chats/" + chat.data("chat-id"), cache: false, async: true, dataType: "json", success: (data) ->
      callback(data)
    })
  
  # Waits for the chat to be handled, loads the messages and calls back.
  chatty_handled = (chat, callback) ->
    chatty_show_messages()
    messages = $(".chatty_messages", chat)
    
    $.ajax({type: "GET", url: "/chatty/chats/" + chat.data("chat-id"), cache: false, async: true, dataType: "json", success: (data) ->
      chat.data("state", data.chat.state)
      
      if data.chat.state == "new"
        messages.text(chat.data("waiting-to-be-handled-message"))
      else if data.chat.state == "closed"
        chatty_show_not_allowed_to_add_messages()
      
      if data.chat.state == "handled" || data.chat.state == "closed"
        callback.call()
      else
        setTimeout((->
          chatty_handled(chat, callback)
        ), 500)
    })
  
  # Inits all messages and begin new messages callback.
  chatty_init_messages = (chat, callback) ->
    chat.data("last-message-id", 0)
    messages_container = $(".chatty_messages", chat)
    messages_container.html("")
    messages_container.slideDown("fast", ->
      $.ajax({type: "GET", url: "/chatty/messages/?q[chat_id_eq]=" + chat.data("chat-id"), cache: false, async: true, dataType: "json", success: (data) ->
        for message in data.messages
          chatty_add_message(chat, message)
        
        callback.call()
      })
    )
  
  chatty_add_message = (chat, message) ->
    msg_id = parseInt(message.id)
    message_class = "chatty_message_" + msg_id
    
    # Dont continue if message already exists!
    return if $("." + message_class, chat).length > 0
    
    last_id = parseInt(chat.data("last-message-id"))
    chat.data("last-message-id", msg_id) if msg_id > last_id
    messages_container = $(".chatty_messages", chat)
    message_class = "chatty_message_" + msg_id
    
    container = $("<div />", {
      "class": "chatty_message " + message_class,
      "data": {
        "message_id": message.id
      },
      "css": {
        "display": "none"
      }
    })
    
    author_div = $("<div />", {
      "class": "chatty_message_author",
      "text": message.author_name
    })
    container.append(author_div)
    
    message_div = $("<div />", {
      "class": "chatty_message_message",
      "text": message.message
    })
    container.append(message_div)
    
    created_at_div = $("<div />", {
      "class": "chatty_message_created_at",
      "text": message.created_at
    })
    container.append(created_at_div)
    
    messages_container.prepend(container)
    container.slideDown("fast")
  
  chatty_refresh_messages = (chat, callback) ->
    last_message_id = chat.data("last-message-id")
    
    $.ajax({type: "GET", url: "/chatty/messages/?q[id_gt]=" + chat.data("last-message-id") + "&q[chat_id_eq]=" + chat.data("chat-id"), cache: false, async: true, dataType: "json", success: (data) ->
      for message in data.messages
        chatty_add_message(chat, message)
    })
  
  chatty_show_not_signed_in_error = (chat) ->
    $(".chatty_not_signed_in_error", chat).slideDown("fast")
  
  chatty_show_cant_add_messages_error = (chat) ->
    $(".chatty_not_allowed_to_add_messages", chat).slideDown("fast")
  
  chatty_show_messages = (chat) ->
    $(".chatty_messages", chat).slideDown("fast")
  
  chatty_init_form = (chat, callback) ->
    if !chat.data("signed-in")
      chatty_show_not_signed_in_error()
      callback.call()
    else if !chat.data("can-add-messages")
      chatty_show_cant_add_messages_error()
      callback.call()
    else if chat.data("state") == "closed"
      callback.call()
    else
      $.ajax({type: "GET", url: "/chatty/messages/new?message[chat_id]=" + chat.data("chat-id"), cache: false, async: true, complete: (data) ->
        form_container = $("<div />", {
          "html": data.responseText,
          "class": "chatty_form",
          "css": {
            "display": "none"
          }
        })
        chat.prepend(form_container)
        form_container.slideDown("fast")
        
        $("form", form_container).bind("ajax:complete", (env, xhr, status) ->
          textfield = $("textarea, input[type=text]", chat)
          chatty_refresh_messages(chat)
          res = $.parseJSON(xhr.responseText)
          
          if !res.success
            alert(res.errors)
          else
            textfield.val("")
          
          textfield.focus()
        )
        
        callback.call()
      })
  
  $(".chatty_chat").each ->
    chat = $(this)
    chatty_init(chat)
