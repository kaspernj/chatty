# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chatty_chat, :class => 'Chatty::Chat' do
    association :user, :factory => :user
    association :resource, :factory => :user
    handled false
  end
end
