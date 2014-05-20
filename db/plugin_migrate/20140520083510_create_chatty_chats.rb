class CreateChattyChats < ActiveRecord::Migration
  def change
    create_table :chatty_chats do |t|
      t.string :user_type
      t.integer :user_id
      t.string :resource_type
      t.integer :resource_id
      t.boolean :handled

      t.timestamps
    end
    
    add_index :chatty_chats, [:user_type, :user_id]
    add_index :chatty_chats, [:resource_type, :resource_id]
  end
end
