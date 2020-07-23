# frozen_string_literal: true

class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json
  #
  # def create
  #   build_resource(sign_up_params)
  #
  #   resource.save
  #   render_resource(resource)
  #
  # end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors }
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end
end
