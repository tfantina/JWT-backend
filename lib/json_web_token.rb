# frozen_string_literal: true

class JsonWebToken
  include BlocklistCreator
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(
      JWT.decode(token,
                 Rails.application.secrets.secret_key_base)[0]
    )
  rescue StandardError
    nil
  end

  def self.create_token(user)
    return nil unless user&.id

    jti = SecureRandom.hex
    exp = (Time.now + 2.hours).to_i

    JsonWebToken.encode(user_id: user.id, jti: jti, exp: exp)
  end

  def self.block_token(token)
    vals, = JWT.decode(token, Rails.application.secrets.secret_key_base)

    user = User.where(id: vals['user_id']).first

    BlocklistCreator.block!(vals['jti'], vals['exp'], user)
  end
end
