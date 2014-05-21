$ ->
  # Adds the messages element and waits for the chat to be handled.
  chatty_init = (chat) ->
    chat.addClass("chat_" + chat.data("chat-id"))
    
    messages = $("<div />", {
      "class": "chatty_messages",
      "text": "Waiting to connect..."
    })
    chat.append(messages)
    
    chatty_handled(chat, ->
      chatty_init_messages(chat, ->
        chatty_init_form(chat, ->
          chatty_refresh_messages(chat)
        )
      )
    )
  
  # Waits for the chat to be handled, loads the messages and calls back.
  chatty_handled = (chat, callback) ->
    $.ajax({type: "GET", url: "/chatty/chats/" + chat.data("chat-id"), cache: false, async: true, dataType: "json", success: (data) ->
      if data.chat.handled
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
    messages_container.slideUp("fast", ->
      messages_container.html("")
      messages_container.slideDown("fast", ->
        $.ajax({type: "GET", url: "/chatty/messages/?q[chat_id_eq]=" + chat.data("chat-id"), cache: false, async: true, dataType: "json", success: (data) ->
          for message in data.messages
            chatty_add_message(chat, message)
          
          callback.call()
        })
      )
    )
  
  chatty_add_message = (chat, message) ->
    last_id = parseInt(chat.data("last-message-id"))
    msg_id = parseInt(message.id)
    chat.data("last-message-id", msg_id) if msg_id > last_id
    
    messages_container = $(".chatty_messages", chat)
    
    container = $("<div />", {
      "class": "chatty_message",
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
    
    messages_container.append(container)
    container.slideDown("fast")
  
  chatty_refresh_messages = (chat, callback) ->
    last_message_id = chat.data("last-message-id")
    
    $.ajax({type: "GET", url: "/chatty/messages/?q[id_gt]=" + chat.data("last-message-id") + "&q[chat_id_eq]=" + chat.data("chat-id"), cache: false, async: true, dataType: "json", success: (data) ->
      for message in data.messages
        chatty_add_message(chat, message)
      
      setTimeout((->
        chatty_refresh_messages(chat)
      ), 1000)
    })
      
  
  chatty_init_form = (chat, callback) ->
    $.ajax({type: "GET", url: "/chatty/messages/new?message[chat_id]=" + chat.data("chat-id"), cache: false, async: true, complete: (data) ->
      form_container = $("<div />", {
        "html": data.responseText,
        "css": {
          "display": "none"
        }
      })
      
      chat.append(form_container)
      form_container.slideDown("fast")
      
      $("form", form_container).bind("ajax:complete", (env, xhr, status) ->
        res = $.parseJSON(xhr.responseText)
        
        if !res.success
          alert(res.errors)
        else
          textfield = $("textarea", chat)
          textfield.val("")
      )
      
      callback.call()
    })
  
  $(".chatty_chat").each ->
    chat = $(this)
    chatty_init(chat)
