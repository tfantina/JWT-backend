class HomeController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: {'jogged_in' => true}
  end
end
