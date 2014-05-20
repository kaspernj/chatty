class CreateChattyMessages < ActiveRecord::Migration
  def change
    create_table :chatty_messages do |t|
      t.integer :chat_id
      t.string :user_type
      t.integer :user_id
      t.text :message

      t.timestamps
    end
    
    add_index :chatty_messages, :chat_id
    add_index :chatty_messages, [:user_type, :user_id]
  end
end
