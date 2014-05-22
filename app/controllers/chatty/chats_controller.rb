require_dependency "chatty/application_controller"

class Chatty::ChatsController < Chatty::ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy, :messages, :handle, :close]
  
  def index
    @ransack_params = params[:q] || {}
    @ransack = Chatty::Chat.ransack(@ransack_params.clone)
    @chats = @ransack.result.order(:id).reverse_order
  end
  
  def show
    respond_to do |format|
      format.json { render(:json => {:chat => @chat.json}) }
      format.html { render :show }
    end
  end
  
  def new
    @chat = Chatty::Chat.new
  end
  
  def edit
  end
  
  def create
    @chat = Chatty::Chat.new(chat_params)

    if @chat.save
      redirect_to @chat, notice: 'Chat was successfully created.'
    else
      render action: 'new'
    end
  end
  
  def update
    if @chat.update(chat_params)
      redirect_to @chat, notice: 'Chat was successfully updated.'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @chat.destroy
    redirect_to chats_url, notice: 'Chat was successfully destroyed.'
  end
  
  def messages
    @messages = @chat.messages
    render :partial => "messages", :layout => false
  end
  
  def handle
    @chat.handle
    @chat.create_activity :key => "chatty/chat.handled", :owner => current_user
    redirect_to chat_path(@chat)
  end
  
  def close
    @chat.close
    @chat.create_activity :key => "chatty/chat.closed", :owner => current_user
    redirect_to chat_path(@chat)
  end
  
private
  
  def set_chat
    @chat = Chatty::Chat.find(params[:id])
    authorize! action_name.to_sym, @chat
  end
  
  def chat_params
    params.require(:chat).permit(:user_type, :user_id, :resource_type, :resource_id)
  end
end
