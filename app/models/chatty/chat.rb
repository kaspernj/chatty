class Chatty::Chat < ActiveRecord::Base
  include PublicActivity::Model
  tracked
  
  belongs_to :resource, :polymorphic => true
  belongs_to :user, :polymorphic => true
  has_many :messages
  
  validates_presence_of :user
  accepts_nested_attributes_for :messages
  
  state_machine :state, :initial => :new do
    event :handle do
      transition [:new, :closed] => :handled
    end
    
    event :close do
      transition :handled => :closed
    end
  end
  
  def json
    return {
      :id => id,
      :state => state
    }
  end
  
  def self.translated_states
    return {
      _("New") => "new",
      _("Handled") => "handled",
      _("Closed") => "closed"
    }
  end
end
