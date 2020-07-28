# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'User have email and password' do
    assert_not User.new(email: 'travis@example.com').valid?
    assert_not User.new(password: 'Password1').valid?
    assert User.new(email: 'ruby@example.com', password: 'Password1').valid?
  end

  test 'Email must be unique' do
    # this is already enforced by Devise but since email is the most important
    # identifier it should be tested in case we ever move away from Devise
    #  or drastically refactor things
    User.create(email: 'viv@example.com', password: 'Password1')
    assert_not User.new(email: 'viv@example.com', password: 'Password2').valid?
  end

  test 'Email must be at least 5 charachters' do
    # Email regrexes are more trouble than they are worth so we do the bare minimum
    assert_not User.new(email: 'h@.c', password: 'Password1').valid?
  end

  test 'Password must be 8 characters' do
    assert_not User.new(email: 'bob@example.com', password: 'passwor').valid?
    assert User.new(email: 'bob@example.com', password: 'password').valid?
  end
end
