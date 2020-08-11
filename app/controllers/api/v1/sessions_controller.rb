# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  include Api::V1::Concerns::Error
  skip_before_action :verify_authenticity_token
  skip_before_action :verify_signed_out_user, only: [:destroy]
  respond_to :json

  def destroy
    @user = User.where(id: params[:user_id])
    @token = params[:auth_token]

    head(404) && return unless @user
    destroy_token(@token)
  end

  def create
    @user = User.find_for_database_authentication(email: params[:email])

    if @user&.valid_password?(params[:password])

      render json: token_return(@user)
    #  render json: SessionSerializer.new(@user).serialized_json
    else
      render json: { errors: ['Invalid Username/Password'] },
             status: :unprocessable_entity
    end
  end

  private

  def token_return(user)
    { auth_token: JsonWebToken.create_token(user),
      user: { id: user.id, email: user.email } }
  end

  def destroy_token(token)
    JsonWebToken.block_token(token)
  end
end
