class Chatty::Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :user, :polymorphic => true
  
  validates_presence_of :chat, :user, :message
  validate :validate_is_chat_open
  
  def json
    return {
      :id => id,
      :message => message,
      :user_id => user.id,
      :user_name => (user[:name].presence || user[:email].presence || user.id),
      :created_at => created_at.strftime("%Y-%m-%d %H:%M:%S")
    }
  end
  
private
  
  def validate_is_chat_open
    if chat.state != "handled"
      errors.add(:chat_id, _("is not open for new messages in that state: %{chat_state}", :chat_state => chat.translated_state))
    end
  end
end
