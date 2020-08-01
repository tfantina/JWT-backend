# frozen_string_literal: true

class Api::V1::RegistrationsController < Devise::RegistrationsController
  include Api::V1::Concerns::Error
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    @user = User.new(sign_up_params)
    if @user.save
      render json: UserSerializer.new(@user).serialized_json
    else
      render_error(@user, :unprocessable_entity)

    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end
end
