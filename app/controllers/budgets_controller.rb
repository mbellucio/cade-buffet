class BudgetsController < ApplicationController
  before_action :authenticate_company!, only: [:new, :create]
  before_action :set_order_check_company_authorization, only: [:new, :create]

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.order.awaiting!
    if @budget.save
      return redirect_to order_path(@budget.order.id), notice: "Orçamento criado!"
    end
    @order = @budget.order
    render "new"
  end

  private
  def set_order_check_company_authorization
    @order = Order.find(params[:order_id])
    if @order.company != current_company
      return redirect_to root_path, alert: "Você não tem acesso a esta tela."
    end
  end

  def budget_params
    params.require(:budget).permit(
      :additional_cost,
      :additional_cost_describe,
      :discount,
      :discount_describe,
      :payment_method_id,
      :proposal_deadline,
      :order_id,
      :base_price
    )
  end
end
