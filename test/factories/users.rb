# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    sequence(:id) { |number| number }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
