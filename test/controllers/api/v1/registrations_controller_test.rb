# frozen_string_literal: true

require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'Should register a new user' do
    pass = Faker::Internet.password
    user_params = {
      email: Faker::Internet.email,
      password: pass,
      password_confirmation: pass
    }

    total_users = User.count
    post '/api/v1/registrations', params: user_params

    assert_response :success
    assert check_for_value(response, %w[data attributes email]) == user_params[:email]
    assert User.count == total_users + 1
  end

  test 'Returns too short error message for short passwords' do
    password = 'toshort'
    user_params = {
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password
    }

    post '/api/v1/registrations', params: user_params

    assert_response 422

    assert check_for_value(response, %w[data attributes errors password])
      .include? 'Passwords must be at least 8 characters long'
  end

  test 'Returns error if there is no email' do
    pass = Faker::Internet.password
    user_params = {
      email: '',
      password: pass,
      password_confirmation: pass
    }

    post '/api/v1/registrations', params: user_params

    assert_response 422
    assert check_for_value(response, %w[data attributes errors email])
      .include? 'Email must be present.'
  end
end
