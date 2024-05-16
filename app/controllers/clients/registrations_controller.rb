# frozen_string_literal: true

class Clients::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) do |client_params|
      client_params.permit(
        :full_name,
        :social_security_number,
        :email,
        :password,
        :password_confirmation
        )
    end
  end
end
