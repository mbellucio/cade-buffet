class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |company_params|
      company_params.permit(
        :buffet_name,
        :company_registration_number,
        :email,
        :password,
        :password_confirmation
        )
    end
  end
end
