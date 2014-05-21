class Chatty::Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :user, :polymorphic => true
  
  validates_presence_of :chat, :user, :message
  
  def json
    return {
      :id => id,
      :message => message,
      :author_name => (user[:name].presence || user[:email].presence || user.id),
      :created_at => created_at.strftime("%Y-%m-%d %H:%M:%S")
    }
  end
end
