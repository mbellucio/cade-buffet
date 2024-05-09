class Api::V1::BuffetsController < ActionController::API
  def index
    if params[:search].present?
      query = params[:search]
      buffets = Buffet.joins(:company).where("buffet_name LIKE ?", "#{query}").order('companies.buffet_name')
    else
      buffets = Buffet.joins(:company).order('companies.buffet_name').all
    end
    render status: 200, json: buffets.as_json(only: [:city, :state_code, :id], methods: [:buffet_name])
  end
end
