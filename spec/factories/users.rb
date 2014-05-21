FactoryGirl.define do
  factory :user do
    email{ Forgery(:internet).email_address }
    password Digest::MD5.hexdigest("123")
  end
end
