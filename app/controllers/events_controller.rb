class EventsController < ApplicationController
  before_action :find_event, only: [:edit, :update, :destroy]
  before_action :authenticate_company!, only: [:create, :edit, :update, :new, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.buffet_id = current_company.buffet.id
    if @event.save
      return redirect_to @event, notice: "Evento cadastrado com sucesso!"
    end
    flash.now[:notice] = "Falha ao cadastrar evento"
    render "new"
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit; end

  def update
    if @event.update(event_params)
      return redirect_to @event, notice: "Evento atualizado com sucesso!"
    end
    flash.now[:notice] = "Falha ao atualizar evento."
    render "edit"
  end

  def destroy
    buffet_id = @event.buffet.id
    @event.event_pricings.each {|ep| ep.destroy}
    @event.destroy
    redirect_to buffet_path(buffet_id), notice: "Evento removido com sucesso!"
  end

  private
  def find_event
    @event = current_company.buffet.events.find_by(id: params[:id])
    if @event.nil?
      redirect_to buffet_path(current_company.buffet.id)
    end
  end

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :min_quorum,
      :max_quorum,
      :standard_duration,
      :menu,
      :serve_alcohol,
      :handle_decoration,
      :valet_service,
      :flexible_location,
    )
  end
end
