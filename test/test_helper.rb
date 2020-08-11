# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...

  def check_for_value(response, dig_val)
    response = JSON.parse(response.body)
    dig_val.each do |dig|
      response = response.dig(dig)
    end
    response
  end
end
