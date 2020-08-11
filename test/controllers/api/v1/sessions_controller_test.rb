# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods
  setup do
    @user = create(:user)
  end

  test 'User can sign in' do
    post '/api/v1/sessions/', params: { email: @user.email, password: @user.password }

    assert_response :success
    assert JSON.parse(response.body).key? 'auth_token'
    assert check_for_value(response, %w[user email]) == @user.email
  end

  test 'User is denied access with incorrect password' do
    post '/api/v1/sessions', params: { email: @user.email, password: 'password1' }

    assert_response 422
    assert check_for_value(response, ['errors']).include? 'Invalid Username/Password'
  end

  test 'User is denied access with nonexistant username' do
    post '/api/v1/sessions', params: { email: 'travis@example.com', password: @user.password }

    assert_response 422
    assert check_for_value(response, ['errors']).include? 'Invalid Username/Password'
  end

  test 'User signs in creates a new session with token' do
    post '/api/v1/sessions', params: { email: @user.email, password: @user.password }
    assert_response :success
    assert check_for_value(response, %w[user email]).include? @user.email
  end

  test 'User can sign out' do
    user = create(:user)
    login_user(user)
    blocked_tokens = BlockedToken.count
    delete "/api/v1/sessions/#{user.id}",
           params: { email: user.email, id: user.id,
                     auth_token: JSON.parse(response.body)['auth_token'] }
    assert_response :success
    assert BlockedToken.count == blocked_tokens + 1
  end

  private

  def login_user(user)
    post '/api/v1/sessions', params: { email: user.email, password: user.password }
  end
end
