class HomeController < ApplicationController
  def index
    if company_signed_in? && current_company.buffet.nil?
      redirect_to new_buffet_path, alert: "Para começar, registre seu Buffet"
    end
  end
end
