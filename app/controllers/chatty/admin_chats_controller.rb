class Chatty::AdminChatsController < Chatty::ApplicationController
  before_filter :set_chat, only: [:handle, :show]

  def index
    @ransack_params = params[:q] || {}
    @ransack = Chatty::Chat.ransack(@ransack_params)
    @chats = @ransack.result.order(:id).reverse_order
  end

  def show
  end

  def handle
    @chat.handle!
    @chat.create_activity key: "chatty/chat.handled", owner: current_user

    redirect_to admin_chat_path(@chat)
  end

private

  def set_chat
    @chat = Chatty::Chat.find(params[:id])
  end
end
