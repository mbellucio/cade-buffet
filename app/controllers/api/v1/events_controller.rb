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

      if events_same_date.any?
        return render status: 200, json: {error: "Esta data está indisponível para este evento"}.to_json
      end

      pricing = event.pricings.find_by(category: set_pricing(booking_date))
      unless pricing.present?
        return render status: 200, json: {error: "Este evento não é realizado neste período da semana"}.to_json
      end

      event_pricing = EventPricing.where(event_id: event.id, pricing_id: pricing.id)
      event_pricing.estimated_price(20)
      estimated_price = event_pricing.estimated_price(guest_number)
      unless estimated_price
        return render status: 200, json: {error: "O número de convidados está acima do número máximo permitido pelo evento"}.to_json
      end

      return render status: 200, json: {valor_previo: "#{estimated_price}" }.to_json
    rescue => e
      Rails.logger.error("Error in show action: #{e.message}")
      render status: 404, json: { error: "#{e.message}" }
    end
  end

  private
  def set_pricing(date)
    if date.saturday? || date.sunday?
      return "Finais de semana e feriados"
    end
    "Dias úteis"
  end
end
