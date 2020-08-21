# frozen_string_literal: true

class Api::V1::PostsController < ApiController
  include Api::V1::Concerns::Error
  skip_before_action :verify_authenticity_token
  def index
    render json: { user: current_user.email, list: [1, 2, 3] }
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      render json: { user: current_user.email, post: @post }
    else
      render json: { error: 'OOPS' }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
