class OrdersController < ApplicationController
  before_action :set_order_and_check_authorization, only: [:show, :confirmed]
  before_action :authenticate_client!, only: [:client, :new, :create]
  before_action :authenticate_company!, only: [:company]

  def show
    if company_signed_in?

      @duplicated_booking_dates = current_company.orders.where.not(id: @order.id).where(booking_date: @order.booking_date)
    end
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
    @orders = current_client.orders.order(created_at: :desc)
    check_proposal_deadline
  end

  def company
    @orders = current_company.orders.order(:status)
    check_proposal_deadline
  end

  def confirmed
    @order.confirmed!
    redirect_to @order
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

  def check_proposal_deadline
    awaiting_orders = @orders.where(status: :awaiting)
    awaiting_orders.each do |order|
      if order.budget.proposal_deadline < Date.today
        order.canceled!
      end
    end
  end

  def set_order_and_check_authorization
    @order = Order.find(params[:id])

    unless client_signed_in? || company_signed_in?
      return redirect_to root_path, notice: "Você não tem acesso a este pedido"
    end

    if client_signed_in? && @order.client != current_client
      return redirect_to root_path, notice: "Você não tem acesso a este pedido"
    end

    if company_signed_in? && @order.company != current_company
      return redirect_to root_path, notice: "Você não tem acesso a este pedido"
    end
  end
end
