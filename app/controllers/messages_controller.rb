class MessagesController < ApplicationController
  before_action :find_order, only: [:create]

  def create
    if company_signed_in?
      message = current_company.messages.new(message_params)
      message.user_id = current_company.id
    else
      message = current_client.messages.new(message_params)
      message.user_id = current_client.id
    end
    message.order_id = @order.id
    if message.save
      return redirect_to @order
    end
  end

  private
  def message_params
    params.require(:message).permit(
      :content,
    )
  end

  def find_order
    @order = Order.find(params[:order_id])
  end
end
