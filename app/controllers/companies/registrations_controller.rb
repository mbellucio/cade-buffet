# frozen_string_literal: true

class Companies::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  protected

  def configure_sign_up_params
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
