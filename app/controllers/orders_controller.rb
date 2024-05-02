class OrdersController < ApplicationController
  before_action :set_order_and_check_user, only: [:show]

  def show
    @order = Order.find(params[:id])
  end

  def new
    @event_pricing = EventPricing.find(params[:event_pricing_id])
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.client_id = current_client.id
    if @order.save
      return redirect_to @order, notice: "Pedido realizado com sucesso!"
    end
    @event_pricing = EventPricing.find(params[:order][:event_pricing_id])
    flash.now[:notice] = "Não foi possível contratar o serviço"
    render "new"
  end

  def client
    @orders = current_client.orders
  end

  private
  def order_params
    params.require(:order).permit(
      :booking_date,
      :predicted_guests,
      :event_details,
      :event_adress,
      :company_id,
      :event_pricing_id
    )
  end

  def set_order_and_check_user
    @order = Order.find(params[:id])
    if @order.client != current_client
      return redirect_to root_path, notice: "Você não tem acesso a este pedido"
    end
  end
end
