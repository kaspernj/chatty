# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chatty_chat, :class => 'Chat' do
    user_type "MyString"
    user_id 1
    resource_type "MyString"
    resource_id 1
    handled false
  end
end
