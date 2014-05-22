class Chatty::MessagesController < Chatty::ApplicationController
  def new
    spawn_message
    render :new, :layout => false
  end
  
  def create
    spawn_message
    
    if @message.save
      render :json => {
        :success => true
      }
    else
      render :json => {
        :success => false,
        :errors => @message.errors.full_messages.join(". ")
      }
    end
  end
  
  def index
    @ransack_params = params[:q] || {}
    @ransack = Chatty::Message.ransack(@ransack_params)
    @messages = @ransack.result.order(:created_at, :id)
    
    respond_to do |format|
      format.json { render(:json => {:messages => @messages.map{ |message| message.json } }) }
    end
  end
  
private
  
  def spawn_message
    if params[:message]
      @message = Chatty::Message.new(message_params)
    else
      @message = Chatty::Message.new
    end
    
    @message.user = current_user
    @message.chat_id = message_params[:chat_id]
  end
  
  def message_params
    params.require(:message).permit(:chat_id, :message)
  end
end
