class BuffetsController < ApplicationController
  before_action :find_buffet, only: [:show]
  before_action :find_client_confirmed_past_orders, only: [:show]
  before_action :find_company_buffet_and_authorize, only: [:edit, :update, :deactivate, :activate]
  before_action :authenticate_company!, only: [:edit, :create, :new, :update, :deactivate, :activate]

  def new
    if current_company.buffet.present?
      redirect_to buffet_path(current_company.buffet.id)
    end
    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.company_id = current_company.id

    if @buffet.save
      return redirect_to buffet_path(@buffet.id), notice: "Buffet Cadastrado com sucesso!"
    end
    flash.now[:notice] = "Cadastro não realizado"
    render "new"
  end

  def show
    if params[:search].present?
      @url = session[:previous_url] = request.referer
    end
  end

  def edit
    @buffet.build_company unless @buffet.company.present?
  end

  def update
    if @buffet.update(buffet_params) && @buffet.company.update(company_params)
      return redirect_to buffet_path(@buffet), notice: "Buffet atualizado com sucesso!"
    end
    find_buffet
    flash.now[:notice] = "Edição não foi bem sucedida"
    render "edit"
  end

  def search
    @query = params[:query]
    result = Buffet.joins(:company, :events).where(
      "buffet_name LIKE ? OR events.name LIKE ? OR city LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%"
    )
    if result.empty?
      result = Buffet.joins(:company).where("buffet_name LIKE ? OR city LIKE ?", "%#{@query}%", "%#{@query}%")
    end
    @buffets = result.includes(:company, :events).sort_by { |buffet| buffet.company.buffet_name }
  end

  def deactivate
    @buffet.update(active: false)
    redirect_to @buffet
  end

  def activate
    @buffet.update(active: true)
    redirect_to @buffet
  end

  private
  def find_company_buffet_and_authorize
    @buffet = Buffet.find(params[:id])

    if @buffet != current_company.buffet
      return redirect_to root_path, alert: "Você não tem acesso a este buffet"
    end
  end

  def buffet_is_active?
    unless @buffet.active
      return redirect_to root_path, alert: "Você não tem acesso a este buffet"
    end
  end

  def find_buffet
    if company_signed_in?
      @buffet = current_company.buffet
    else
      @buffet = Buffet.find(params[:id])
      buffet_is_active?
    end
  end

  def find_client_confirmed_past_orders
    if client_signed_in?
      @client_confirmed_past_orders = @buffet.company.orders
        .where(client_id: current_client.id)
        .where(status: :confirmed)
        .filter {|order| Date.today > order.booking_date}
    end
  end

  def buffet_params
    params.require(:buffet).permit(
      :company_name,
      :phone_number,
      :zip_code,
      :adress,
      :neighborhood,
      :city,
      :state_code,
      :description,
      :email,
      :cover,
      images: [],
      payment_method_ids: []
    )
  end

  def company_params
    params.require(:buffet).require(:company_attributes).permit(
      :buffet_name
    )
  end
end
