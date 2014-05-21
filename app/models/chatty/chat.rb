class Chatty::Chat < ActiveRecord::Base
  include PublicActivity::Model
  tracked
  
  belongs_to :resource, :polymorphic => true
  belongs_to :user, :polymorphic => true
  has_many :messages
  
  validates_presence_of :user
  
  accepts_nested_attributes_for :messages
  
  def json
    return {
      :id => id,
      :handled => handled
    }
  end
end
