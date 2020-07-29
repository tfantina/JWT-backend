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
    assert JSON.parse(response.body).include? 'auth_token'
    assert JSON.parse(response.body)['user']['email'] == @user.email
  end

  test 'User is denied access with incorrect password' do
    post '/api/v1/sessions', params: { email: @user.email, password: 'password1' }

    assert JSON.parse(response.body)['errors'].include? 'Invalid Username/Password'
  end

  test 'User is denied access with nonexistant username' do
    post '/api/v1/sessions', params: { email: 'travis@example.com', password: @user.password }

    assert JSON.parse(response.body)['errors'].include? 'Invalid Username/Password'
  end
end
