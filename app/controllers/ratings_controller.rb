class RatingsController < ApplicationController
  before_action :find_buffet, only: [:new, :create, :index]

  def new
    @rating = Rating.new
  end

  def index; end

  def create
    @rating = Rating.new(rating_params)
    @rating.buffet = @buffet
    @rating.client = current_client
    if @rating.save
      return redirect_to buffet_path(@buffet.id), notice: "Avaliação enviada com sucesso!"
    end
    flash.now[:alert] = "Não foi possível enviar avaliação"
    render "new"
  end

  private
  def rating_params
    params.require(:rating).permit(
      :image,
      :value,
      :feedback
    )
  end

  def find_buffet
    @buffet = Buffet.find(params[:buffet_id])
  end
end
