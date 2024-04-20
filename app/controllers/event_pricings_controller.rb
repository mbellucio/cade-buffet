class EventPricingsController < ApplicationController
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
  end

  private
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
