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
    render "edit"
  end

  def destroy
    event_id = @event_pricing.event.id
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

