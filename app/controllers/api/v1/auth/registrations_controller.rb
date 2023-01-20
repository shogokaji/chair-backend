class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  protect_from_forgery

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :name, :image)
  end
end
