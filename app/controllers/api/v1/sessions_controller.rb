# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:create]
  respond_to :json

  def destroy; end

  def create
    user = User.find_for_database_authentication(email: params[:email])

    if user&.valid_password?(params[:password])
      puts payload(user)
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user&.id

    { auth_token: JsonWebToken.encode(user_id: user.id),
      user: { id: user.id, email: user.email } }
  end

  def respond_to_on_destroy
    head :no_content
  end
end
