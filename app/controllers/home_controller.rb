class HomeController < ApplicationController
  before_action :redirect_company

  def index
    @buffets = Buffet.where(active: true)
  end

  def redirect_company
    if company_signed_in?
      return redirect_to buffet_path(current_company.buffet.id)
    end
  end
end
