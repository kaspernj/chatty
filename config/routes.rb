Chatty::Engine.routes.draw do
  namespace :admin do
    resources :chats
  end

  resources :chats do
    member do
      get :messages
      post :handle
      post :close
    end
  end

  resources :messages
end
