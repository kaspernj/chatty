[![Build Status](https://api.shippable.com/projects/540e7b9a3479c5ea8f9ec203/badge?branchName=master)](https://app.shippable.com/projects/540e7b9a3479c5ea8f9ec203/builds/latest)
[![Code Climate](https://codeclimate.com/github/kaspernj/chatty.png)](https://codeclimate.com/github/kaspernj/chatty)
[![Test Coverage](https://codeclimate.com/github/kaspernj/chatty/badges/coverage.svg)](https://codeclimate.com/github/kaspernj/chatty)

# Chatty

## Install

First bundle it in your Gemfile:
```ruby
gem "chatty"
```

Execute `bundle install`.

Throw something like this in your `application.js.coffee`:
```coffeescript
#= require chatty
```

Trow this in your `ApplicationHelper`:
```ruby
class ApplicationHelper
  include Chatty::ChatsHelper
end
```

Add abilities for who can create and access chats through CanCan:
```ruby
class Ability
  include CanCan::Ability
  
  def initialize(user)
    if user
      can :show, Chatty::Chat
      
      can [:new, :create], Chatty::Message
      can [:edit, :update], Chatty::Message do |message|
        if message.user == user
          true
        else
          false
        end
      end
      
      if user.email == "admin@example.com"
        can :manage, Chatty::Chat
        can :manage, Chatty::Message
      end
    end
  end
end
```

## Usage
Create a chat somewhere in your code:
```ruby
chat = Chatty::Chat.new(:user => current_user)
```

Show that same chat in a view:
```erb
<%= chatty_chat(@chat) %>
```

Try to view that chat with the user that got attached and with an admin in another window. Now start chatting!

Inspect the HTML to style that shit yourself!
