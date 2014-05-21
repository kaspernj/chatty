Chatty::Engine.routes.draw do
  resources :chats do
    get :messages, :on => :member
  end
  
  resources :messages
  
  resources :admin_chats do
    post :handle, :on => :member
  end
end
