class Api::V1::EventsController < ActionController::API
  def index
    begin
      buffet = Buffet.find(params[:buffet_id])
      render status: 200, json: buffet.events.order(:name).as_json(except: [:created_at, :updated_at, :buffet_id, ])
    rescue
      render status: 404
    end
  end

end
