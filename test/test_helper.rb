ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_difference(object, method,difference = 1)
    initial_value = object.send(method)
    yield
    assert_equal initial_value + difference, object.send(method)
  end

  def assert_no_difference(object,method,&block)
    assert_difference(object,method,0,&block)
  end

end
