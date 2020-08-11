# frozen_string_literal: true

module BlocklistCreator
  def self.block!(jti, exp, user)
    user.blocked_tokens.create!(
      jti: jti,
      exp: Time.at(exp)
    )
  end

  def is_blocked?(jti)
    BlockedToken.exists?(jti: jti)
  end
end
