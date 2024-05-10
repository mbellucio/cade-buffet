class Api::V1::EventsController < ActionController::API
  def index
    begin
      buffet = Buffet.find(params[:buffet_id])
      render status: 200, json: buffet.events.order(:name).as_json(
        except: [:created_at, :updated_at, :buffet_id],
        include: {buffet: {methods: [:buffet_name], only: [:id]}}
        )
    rescue
      render status: 404
    end
  end

  def show
    begin
      booking_date = Date.parse(params[:booking_date])
      guest_number = params[:guest_number].to_i
      event = Event.find(params[:id])
      events_same_date = event.buffet.company.orders.where(status: [:awaiting, :confirmed], booking_date: booking_date)

      if booking_date <= Date.today
        return render status: 200, json: {error: "A data deve ser futura"}.to_json
      end

      if events_same_date.any?
        return render status: 200, json: {error: "Esta data está indisponível para este evento"}.to_json
      end

      pricing = event.pricings.find_by(category: set_pricing(booking_date))
      unless pricing.present?
        return render status: 200, json: {error: "Este evento não é realizado neste período da semana"}.to_json
      end

      event_pricing = EventPricing.where(event_id: event.id, pricing_id: pricing.id)[0]
      estimated_price = estimate_price(guest_number, event_pricing)
      unless estimated_price
        return render status: 200, json: {error: "O número de convidados está acima do número máximo permitido pelo evento"}.to_json
      end

      return render status: 200, json: {event_id: event.id, event: event.name, estimated_price: estimated_price }.to_json
    rescue
      render status: 404
    end
  end

  private
  def set_pricing(date)
    if date.saturday? || date.sunday?
      return "Finais de semana e feriados"
    end
    "Dias úteis"
  end

  def estimate_price(guests, event_pricing)
    if guests > event_pricing.event.max_quorum
      return false
    end

    if guests <= event_pricing.event.min_quorum
      return event_pricing.base_price
    end

    ((guests - event_pricing.event.min_quorum) * event_pricing.extra_person_fee) + event_pricing.base_price
  end
end
