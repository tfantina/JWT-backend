# frozen_string_literal: true

class SessionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :auth_token

  attribute :auth_token do |object|
    object.auth_token.to_s
  end
end
