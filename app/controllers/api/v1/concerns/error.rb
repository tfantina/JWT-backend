# frozen_string_literal: true

module Api::V1::Concerns
  module Error
    extend ActiveSupport::Concern

    included do
      helper_method :render_error
    end

    def render_error(resource, status)
      render json: ErrorSerializer.new(resource).serialized_json, status: status
    end
  end
end
