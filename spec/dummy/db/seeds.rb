puts "Creating users."
user = User.find_or_initialize_by(:email => "admin@example.com")
user.assign_attributes(
  :password => "password"
)
user.save!

puts "Creating chats."
chat = Chatty::Chat.find_or_initialize_by(:id => 1)
chat.assign_attributes(
  :user => user,
  :resource => user,
  :handled => false
)
chat.save!
