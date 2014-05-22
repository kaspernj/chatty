Chatty::Engine.routes.draw do
  resources :chats do
    get :messages, :on => :member
    post :handle, :on => :member
    post :close, :on => :member
  end
  
  resources :messages
end
