# frozen_string_literal: true

class Api::V1::PostController < ApiController
  #  before_action :authenticate_user!
  def index
    render json: { user: current_user.email, list: [1, 2, 3] }
  end
end
