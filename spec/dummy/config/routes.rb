Rails.application.routes.draw do
  devise_for :users
  mount Chatty::Engine => "/chatty"
  
  root "chatty/admin_chats#index"
end
