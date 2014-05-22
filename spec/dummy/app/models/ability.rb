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
