require 'test_helper'

class PublishersControllerTest < ActionController::TestCase
  fixtures :authors, :publishers, :books
  setup do
    @controller = Admin::PublishersController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  def test_create
    num_publishers =  Publisher.count
    post :create, :publisher => {:name => 'The Monpoly publishing company'}
    assert_response :redirect
    assert_equal flash[:notice], 'Publisher was successfully created.'

    assert_equal num_publishers + 1, Publisher.count
  end
end
