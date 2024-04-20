class BuffetsController < ApplicationController
  before_action :find_buffet, only: [:show, :edit, :update]
  before_action :authenticate_company!

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

  def show; end

  def edit
    @buffet.build_company unless @buffet.company.present?
  end

  def update
    if @buffet.update(buffet_params) && @buffet.company.update(company_params)
      return redirect_to buffet_path(@buffet), notice: "Buffet atualizado com sucesso!"
    end
  end

  private

  def find_buffet
    @buffet = current_company.buffet
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
      :payment_method
    )
  end

  def company_params
    params.require(:buffet).require(:company_attributes).permit(
      :buffet_name
    )
  end
end
