class EventPricingsController < ApplicationController
  before_action :find_event_pricing, only: [:edit, :update, :destroy]
  before_action :authenticate_company!

  def new
    @event = Event.find(params[:event_id])
    @pricing = Pricing.find(params[:pricing_id])
    @event_pricing = EventPricing.new
  end

  def create
    @event_pricing = EventPricing.new(event_pricing_params)
    if @event_pricing.save
      return redirect_to @event_pricing.event
    end
    get_event_and_pricing
    render "new"
  end

  def edit
    get_event_and_pricing
  end

  def update
    if @event_pricing.update(event_pricing_params)
      return redirect_to @event_pricing.event
    end
    get_event_and_pricing
    flash.now[:alert] = "Edição não foi bem sucedida"
    render "edit"
  end

  def destroy
    event_id = @event_pricing.event.id
    if @event_pricing.orders.any?
      return redirect_to event_path(event_id), alert: "Existem pedidos ativos com esta precificação, impossível deletar."
    end
    @event_pricing.destroy
    redirect_to event_path(event_id)
  end

  private
  def get_event_and_pricing
    @event = @event_pricing.event
    @pricing = @event_pricing.pricing
  end

  def find_event_pricing
    @event_pricing = EventPricing.find(params[:id])

    if @event_pricing.event.buffet.company != current_company
      return redirect_to root_path, alert: "Você não tem acesso a este evento"
    end
  end

  def event_pricing_params
    params.require(:event_pricing).permit(
      :base_price,
      :extra_person_fee,
      :extra_hour_fee,
      :pricing_id,
      :event_id
    )
  end
end
