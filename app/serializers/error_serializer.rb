# frozen_string_literal: true

class ErrorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :errors
end
