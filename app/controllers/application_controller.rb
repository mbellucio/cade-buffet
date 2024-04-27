class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :force_redirect_if_company_has_no_buffet

  def force_redirect_if_company_has_no_buffet
    if company_signed_in? && current_company.buffet.nil?

      current_path = url_for(only_path: true)
      Rails.logger.debug "Current Path: #{current_path}"
      Rails.logger.debug "Destroy Company Session Path: #{destroy_company_session_path}"
      Rails.logger.debug "New Buffet Path: #{new_buffet_path}"
      Rails.logger.debug "Buffets Path: #{buffets_path}"
      unless current_path == destroy_company_session_path || current_path == new_buffet_path || current_path == buffets_path
        Rails.logger.debug "Redirecting to New Buffet Path"
        redirect_to new_buffet_path, alert: "Para começar, registre seu Buffet"
      end
    end
  end

  protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) do |company_params|
  #     company_params.permit(
  #       :buffet_name,
  #       :company_registration_number,
  #       :email,
  #       :password,
  #       :password_confirmation
  #       )
  #   end
  # end
end
