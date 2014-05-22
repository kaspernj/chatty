Rails.application.routes.draw do
  devise_for :users
  mount Chatty::Engine => "/chatty"
  
  root "chatty/chats#index"
end
