FactoryBot.define do
  factory :blocked_token do
    jti { "MyString" }
    user { nil }
    exp { "2020-08-05 19:39:36" }
  end
end
