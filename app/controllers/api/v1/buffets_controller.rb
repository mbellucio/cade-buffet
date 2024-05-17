class Api::V1::BuffetsController < ActionController::API
  def index
    if params[:search].present?
      query = params[:search]
      buffets = Buffet.joins(:company).where("buffet_name LIKE ? AND active = ?", "#{query}", true).order('companies.buffet_name')
    else
      buffets = Buffet.joins(:company).where(active: true).order('companies.buffet_name').all
    end
    render status: 200, json: buffets.as_json(only: [:city, :state_code, :id], methods: [:buffet_name])
  end

  def show
    begin
      buffet = Buffet.find(params[:id])
      render status: 200, json: buffet.as_json(
        include: {payment_methods: {only: [:method]}},
        except: [:created_at, :updated_at, :company_id, :company_name],
        methods: [:buffet_name, :average_rating]
      )
    rescue
      render status: 404
    end
  end
end
