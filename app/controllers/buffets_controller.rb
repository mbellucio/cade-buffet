class BuffetsController < ApplicationController
  def new
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
    @buffet = Buffet.find(params[:id])
  end

  private

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
    )
  end
end
