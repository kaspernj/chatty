require_dependency "chatty/application_controller"

class Chatty::ChatsController < Chatty::ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy, :messages]

  # GET /chats
  def index
    @chats = Chatty::Chat.all
  end

  # GET /chats/1
  def show
    respond_to do |format|
      format.json { render(:json => {:chat => {:id => @chat.id, :handled => @chat.handled}}) }
      format.html { render :show }
    end
  end

  # GET /chats/new
  def new
    @chat = Chatty::Chat.new
  end

  # GET /chats/1/edit
  def edit
  end

  # POST /chats
  def create
    @chat = Chatty::Chat.new(chat_params)

    if @chat.save
      redirect_to @chat, notice: 'Chat was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      redirect_to @chat, notice: 'Chat was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
    redirect_to chats_url, notice: 'Chat was successfully destroyed.'
  end
  
  def messages
    @messages = @chat.messages
    render :partial => "messages", :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chatty::Chat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.require(:chat).permit(:user_type, :user_id, :resource_type, :resource_id, :handled)
    end
end
