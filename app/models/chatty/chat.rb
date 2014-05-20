class Chatty::Chat < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  belongs_to :user, :polymorphic => true
  
  validates_presence_of :resource, :user
end
