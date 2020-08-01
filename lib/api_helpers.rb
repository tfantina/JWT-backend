# frozen_string_literal: true

module ApiHelpers
  def render_error(resource, status)
    render json: resource,
           status: status
  end
end
