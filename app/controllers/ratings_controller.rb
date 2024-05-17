class RatingsController < ApplicationController
  before_action :authenticate_client!, only: [:create, :new]
  before_action :find_buffet, only: [:new, :create, :index]
  before_action :client_already_rated, only: [:create]


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
  def client_already_rated
    if @buffet.ratings.where(client_id: current_client.id).any?
      return redirect_to root_path, alert: "Você já avaliou este buffet."
    end
  end

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
