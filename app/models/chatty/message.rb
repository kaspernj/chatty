class Chatty::Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :user, :polymorphic => true
  
  validates_presence_of :chat, :user, :message
end
